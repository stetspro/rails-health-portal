class PatientsController < ApplicationController
  before_action :authenticate_patient!
  before_action :restrict_patient!, only: [:edit, :update, :destroy]

  def index
    @patients = Patient.all
  end

  def dashboard
    @patient = current_patient
    @appointments = current_patient.appointments
  end

  def show
    @patient = Patient.find(params[:id])
  end

  def new
    @patient = Patient.new
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      redirect_to @patient
    else
      render :new
    end
  end

  def edit
    @patient = Patient.find(params[:id])
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      redirect_to @patient
    else
      render :edit
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    @patient.destroy
    redirect_to patients_path
  end

  private
   def patient_params
    params.require(:patient).permit(:first_name, :last_name, :email, :date_of_birth, :address, :password, :password_confirmation)
  end
end
