class OpenaiService
  def self.send_diagnosis(patient_diagnosis)
    diagnosis = Diagnosis.find(patient_diagnosis.diagnosis_id)
    complaint = patient_diagnosis.complaint
    today = Date.today

    conversation = [
       {role: "user", content: "Today is #{today}, patient has #{diagnosis.name} with complaints of #{complaint}, provide an appointment date to the patient.Format:'yyyy-mm-dd'.Least words as possible."}
    ]

    client = OpenAI::Client.new
    result = client.chat(
      parameters:{
        model: "gpt-3.5-turbo",
        messages: conversation,
        temperature: 0.5,
      }
    )

    result
  end
end
