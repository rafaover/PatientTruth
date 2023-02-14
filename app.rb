require_relative 'main'

puts "Let's start the process. The idea is to build a document with your
own choices. Comunication is a big issue when you're dealing with a subject
you have no domain. Let's try to make it clear."

select_gender
symptoms = select_symptoms
body_parts = select_body_parts
pain = pain_presence

case pain
when "yes"
  pain_level = input_pain_level
  pain_start = input_pain_start
  body_pain = body_parts_with_pain
  puts "Thank you, lets generate your document"
  patient_letter(
    text_build_with_pain(
      symptoms,
      body_parts,
      pain_start,
      pain_level,
      body_pain
    )
  )
when "no"
  puts "Thank you, lets generate your document"
  patient_letter(text_build_no_pain(symptoms, body_parts))
end
