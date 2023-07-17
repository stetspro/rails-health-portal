class PatientDiagnosesController < ApplicationController
  before_action :set_patient, only: [:new, :create]

  def new
    @appointment = Appointment.find(params[:appointment_id])
    @diagnosis = @patient.diagnoses.build
  end

  def create
    @appointment = Appointment.find(params[:appointment_id])
    @diagnosis = @patient.diagnoses.build(diagnosis_params)

    if @diagnosis.save
      @diagnosis.update_attribute(:created_at, (@appointment.appointment_date.to_date.to_s + ' ' + @appointment.appointment_time.strftime("%H:%M:%S")).to_datetime.in_time_zone("Eastern Time (US & Canada)"))
      redirect_to patient_path(@patient), notice: 'Diagnosis was successfully created.'
    else
      render :new
    end
  end

  private

  def set_patient
    @appointment = Appointment.find(params[:appointment_id])
    @patient = @appointment.patient
  end
  

  def diagnosis_params
    params.require(:diagnosis).permit(:name, :description, :is_chronic)
  end
end
