require_relative 'main'

puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>"
puts "Let's start the process. The idea is to build a document with your own choices. Comunication is a big issue when you're dealing with a subject you have no domain. Let's try to make it clear."
puts " "

Model.select_gender
symptoms = Model.select_symptoms
body_parts = Model.select_body_parts
pain = Model.pain_presence

case pain
when "yes"
  pain_level = Model.input_pain_level
  pain_start = Model.input_pain_start
  body_pain = Model.body_parts_with_pain
  puts "Thank you, lets generate your document"
  Model.patient_letter(
    Model.text_build_with_pain(
      symptoms,
      body_parts,
      pain_start,
      pain_level,
      body_pain
    )
  )
when "no"
  puts "Thank you, lets generate your document"
  Model.patient_letter(Model.text_build_no_pain(symptoms, body_parts))
end
