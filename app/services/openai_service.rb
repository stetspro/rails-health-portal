class OpenaiService
  def self.send_diagnosis(patient_diagnosis)
    diagnosis = Diagnosis.find(patient_diagnosis.diagnosis_id)
    complaint = patient_diagnosis.complaint
    today = Date.today

    conversation = [
      {role: "system", content: "You are a helpful assistant that provides medical scheduling advice."},
       {role: "user", content: "Given that today's date is #{today} and the patient has #{diagnosis.name} with complaints of #{complaint}, please provide a single appointment date considering the patient's history. Your answer must be a single date in the format 'yyyy-mm-dd'.Answer in the least words as possible."}
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
