# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Hospital.create(name: 'Hospital 1', address: '123 Street, City, Country')
Hospital.create(name: 'Hospital 2', address: '456 Avenue, City, Country')
Hospital.create(name: 'Hospital 3', address: '789 Boulevard, City, Country')


medications = [
  { pharmacological_name: "Acetaminophen", brand_name: "Tylenol", dosage: "500mg", frequency: "Every 6 hours", delivery: "Oral" },
  { pharmacological_name: "Ibuprofen", brand_name: "Advil", dosage: "200mg", frequency: "Every 4 to 6 hours", delivery: "Oral" },
  { pharmacological_name: "Amlodipine", brand_name: "Norvasc", dosage: "5mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Amoxicillin", brand_name: "Amoxil", dosage: "500mg", frequency: "Every 8 hours", delivery: "Oral" },
  { pharmacological_name: "Atorvastatin", brand_name: "Lipitor", dosage: "20mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Cetirizine", brand_name: "Reactine", dosage: "10mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Clopidogrel", brand_name: "Plavix", dosage: "75mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Diphenhydramine", brand_name: "Benadryl", dosage: "25mg", frequency: "Every 4 to 6 hours", delivery: "Oral" },
  { pharmacological_name: "Duloxetine", brand_name: "Cymbalta", dosage: "60mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Escitalopram", brand_name: "Cipralex", dosage: "10mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Hydrochlorothiazide", brand_name: "Hydrodiuril", dosage: "25mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Lisinopril", brand_name: "Prinivil", dosage: "10mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Metformin", brand_name: "Glucophage", dosage: "500mg", frequency: "Twice daily", delivery: "Oral" },
  { pharmacological_name: "Metoprolol", brand_name: "Lopressor", dosage: "50mg", frequency: "Twice daily", delivery: "Oral" },
  { pharmacological_name: "Omeprazole", brand_name: "Prilosec", dosage: "20mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Pregabalin", brand_name: "Lyrica", dosage: "75mg", frequency: "Twice daily", delivery: "Oral" },
  { pharmacological_name: "Simvastatin", brand_name: "Zocor", dosage: "20mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Tadalafil", brand_name: "Cialis", dosage: "10mg", frequency: "As needed", delivery: "Oral" },
  { pharmacological_name: "Venlafaxine", brand_name: "Effexor", dosage: "75mg", frequency: "Once daily", delivery: "Oral" },
  { pharmacological_name: "Warfarin", brand_name: "Coumadin", dosage: "5mg", frequency: "Once daily", delivery: "Oral" },
]

medications.each do |medication|
  Medication.create!(medication)
end


PatientMedication.create(patient_id: 1, medication_id: rand(1..20), expiration_date: '2023-07-30')
PatientMedication.create(patient_id: 1, medication_id: rand(1..20), expiration_date: '2023-06-20')
