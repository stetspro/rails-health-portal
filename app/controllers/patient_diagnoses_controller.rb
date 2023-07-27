class PatientDiagnosesController < ApplicationController
  # This method is called when loading the new patient diagnosis form
  def new
    # Get the appointment from the database using the id passed in the URL parameters
    @appointment = Appointment.find(params[:appointment_id])
    # Get the patient from the database using the id passed in the URL parameters
    @patient = Patient.find(params[:patient_id])
    # Create a new, unsaved patient diagnosis and patient medication instance for the form to use
    @patient_diagnosis = PatientDiagnosis.new
    @patient_medication = PatientMedication.new
    # Get the doctor id from the appointment for later use
    @doctor = @appointment[:doctor_id]
    @medications = Medication.all
    # Fetch the current and expired medications
    @current_medications = @patient.patient_medications.includes(:medication).where('expiration_date >= ?', Date.today)
    @expired_medications = @patient.patient_medications.includes(:medication).where('expiration_date < ?', Date.today).last(5)
    # Fetch the previous chronic diagnoses
    chronic_diagnoses_ids = @patient.patient_diagnoses
    .joins(:diagnosis)
    .where(diagnoses: { is_chronic: true })
    .group(:diagnosis_id)
    .select('MIN(patient_diagnoses.id) as id')
  
    @chronic_diagnoses = PatientDiagnosis.where(id: chronic_diagnoses_ids.map(&:id)).order(created_at: :desc)
  end
  
  # This method is called when submitting the new patient diagnosis form
  def create
    # Get the patient from the database using the id passed in the form parameters
    @patient = Patient.find(params[:patient_id])
  
    # Create a new patient diagnosis instance and associate it with the patient
    @patient_diagnosis = @patient.patient_diagnoses.new(patient_diagnosis_params)

    # Create a new PatientMedication instance and set the patient_id field
    @patient_medication = PatientMedication.new(patient_medication_params.merge(patient_id: @patient.id))

    # Attempt to save the new patient diagnosis instance to the database
    if @patient_diagnosis.save
      # If medication_id and expiration_date were provided in the form, create associated PatientMedication record
      if params[:patient_medication][:medication_id].present? && params[:patient_medication][:expiration_date].present?
        @patient_medication.patient_diagnosis_id = @patient_diagnosis.id
  
        # Attempt to save the new PatientMedication instance to the database
        if @patient_medication.save
          # If save was successful, send the patient diagnosis and medication to OpenAI for processing
          session[:openai_result] = check_and_send_to_openai(@patient_diagnosis, @patient_medication)
        end
      else
        # If medication_id or expiration_date were not provided, send only the patient diagnosis to OpenAI for processing
        session[:openai_result] = check_and_send_to_openai(@patient_diagnosis, nil)
      end
      
      if session[:openai_result]
        # If OpenAI processing was successful, redirect to the scheduling page
        redirect_to scheduler_patient_diagnosis_path(@patient_diagnosis)
      else
        # If OpenAI processing was not successful, redirect to the doctor's patient list
        redirect_to daily_patients_doctor_path(session[:doctor_id]), notice: 'Patient diagnosis was successfully created.'
      end
    else
      # If save was not successful, render the form again, displaying any error messages
      render :new
    end
  end
  
  # Display the suggested appointment date to the doctor. This uses the OpenAI result stored in the session to determine this suggested date.
  def scheduler
    # Create a new instance of AiScheduler for the form to use
    @ai_scheduler = AiScheduler.new
    # Get the patient diagnosis from the database using the id passed in the URL parameters
    @patient_diagnosis = PatientDiagnosis.find(params[:id])
    # Get the patient related to this patient diagnosis
    @patient = @patient_diagnosis.patient
    # Parse the suggested date from the OpenAI result stored in the session
    @suggested_date = parse_date_from_openai(session[:openai_result])
    # Clear the OpenAI result from the session now that we've used it
    session.delete(:openai_result)
  end

  # Create a new AiScheduler record with the confirmed appointment date
  def confirm_schedule
    # Get the patient diagnosis from the database using the id passed in the URL parameters
    @patient_diagnosis = PatientDiagnosis.find(params[:id])
    # Get the patient related to this patient diagnosis
    @patient = @patient_diagnosis.patient
    # The date is taken from the form submission
    AiScheduler.create(
      patient: @patient,
      date: params[:ai_scheduler][:date],
      patient_diagnosis: @patient_diagnosis,
      has_taken_appointment: false,
      doctor: Doctor.find(session[:doctor_id])
    )
    # After the schedule is confirmed, redirect to the doctor's patient list
    redirect_to daily_patients_doctor_path(session[:doctor_id])
  end

  private
  # This function extracts the date from OpenAI's output. It assumes the date is in 'yyyy-mm-dd' format and is the last word in the output.
  def parse_date_from_openai(openai_result)
    date_str = openai_result["choices"].first["message"]["content"]
    Date.parse(date_str)
  end

  # This function sends the diagnosis to OpenAI if it's a chronic disease
  def check_and_send_to_openai(patient_diagnosis, patient_medication)
    diagnosis = Diagnosis.find(patient_diagnosis.diagnosis_id)
  
    if diagnosis.is_chronic
      # Get the medication associated with the patient_diagnosis object if it exists
      medication = patient_medication.nil? ? nil : Medication.find(patient_medication.medication_id)
  
      # Send the patient_diagnosis object and medication to OpenAI for processing
      OpenaiService.send_diagnosis(patient_diagnosis, medication)
    end
  end
  
  def patient_diagnosis_params
    params.require(:patient_diagnosis).permit(:complaint, :diagnosis_id, :patient_id)
  end

  def patient_medication_params
    params.require(:patient_medication).permit(:medication_id, :expiration_date)
  end
end
