class DoctorsController < ApplicationController
  def index
    @doctors = Doctor.all
  end

  def show
    @doctor = Doctor.find(params[:id])
  end

  def new
    @doctor = Doctor.new
  end

  def create
    @doctor = Doctor.new(doctor_params)
    if @doctor.save
      redirect_to @doctor
    else
      render :new
    end
  end

  def edit
    @doctor = Doctor.find(params[:id])
  end

  def update
    @doctor = Doctor.find(params[:id])
    if @doctor.update(doctor_params)
      redirect_to @doctor
    else
      render :edit
    end
  end

  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.destroy
    redirect_to doctors_path
  end

  private
  def doctor_params
    params.require(:doctor).permit(:name, :specialization, :email, :address)
  end
end
