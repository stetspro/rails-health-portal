require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  let(:valid_attributes) {
    { appointment_date: Time.now + 1.day, patient_id: 1, doctor_id: 1 }
  }

  let(:invalid_attributes) {
    { appointment_date: nil, patient_id: nil, doctor_id: nil }
  }

  describe "GET #index" do
    it "returns a success response" do
      Appointment.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      appointment = Appointment.create! valid_attributes
      get :show, params: { id: appointment.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      it "creates a new Appointment" do
        expect {
          post :create, params: { appointment: valid_attributes }
        }.to change(Appointment, :count).by(1)
      end

      it "redirects to the created appointment" do
        post :create, params: { appointment: valid_attributes }
        expect(response).to redirect_to(Appointment.last)
      end
    end

    context "with invalid parameters" do
      it "does not create a new Appointment" do
        expect {
          post :create, params: { appointment: invalid_attributes }
        }.to change(Appointment, :count).by(0)
      end

      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { appointment: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end