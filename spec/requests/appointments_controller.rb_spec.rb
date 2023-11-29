require 'rails_helper'

RSpec.describe "AppointmentsController.rbs", type: :request do
    describe "GET #new" do
      before do
        get :new
      end
      it "responds successfully" do
        expect(response).to be_successful
      end

      it "assigns @appointment" do
        expect(assigns(:appointment)).to be_a_new(Appointment)
      end
  end
end
