# rubocop:disable Metric/MethodLength Metrics/AbcSize
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/StringLiterals
# rubocop:disable Style/StringLiteralsInInterpolation

require 'ruby/openai'

  private

API_KEY = "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"
SYMPTOMS = ["Headache", "Fever", "Fatigue", "Nausea", "Vomiting",
  "Chest pain", "Abdominal pain", "Joint pain", "Muscle pain", "Back pain",
  "Shortness of breath", "Cough", "Sore throat", "Runny nose", "Diarrhea",
  "Constipation", "Rash", "Numbness", "Tingling", "Blurred vision"]
BODY_PARTS = ["Head", "Neck", "Shoulder", "Back", "Chest", "Abdomen", "Hips",
  "Thighs", "Knees", "Calves", "Ankles", "Feet", "Wrists", "Hands", "Elbows",
  "Arms", "Shoulders", "Stomach", "Groin"]

def patient_letter(text)
  client = OpenAI::Client.new(access_token: API_KEY)
  prompt = text
  response = client.completions(
    parameters: {
      model: 'text-davinci-003',
      prompt: prompt,
      temperature: 0.5,
      max_tokens: 1000
    }
  )

  puts response['choices'][0]['text']
end

def select_gender
  puts "Select your gender:"
  puts "1. Male"
  puts "2. Female"
  puts "3. Other"
  gender = gets.chomp.to_i

  case gender
  when 1
    puts "Thank you Sir"
    "Male"

  when 2
    puts "Thank you"
    "Female"
  when 3
    puts "Thank you"
    "Other"
  else
    "Invalid selection. Please select 1, 2, or 3."
  end
end

def select_body_parts
  puts "Please select the body parts where you are feeling symptoms (use the corresponding number). When you're done
  write 'done':"

  BODY_PARTS.each_with_index do |part, index|
    puts "#{index + 1}. #{part}"
  end

  selected_body_parts = []
  loop
  user_input = gets.chomp
  break if user_input == "done"

  selected_body_part = body_parts[user_input.to_i - 1]
  selected_body_parts << selected_body_part if selected_body_part
  selected_body_parts.join(", ")
end

def select_symptoms
  list_symptoms
  selected_symptoms = []
  while selected_symptoms.empty?
    selected_indexes = gets.chomp.split(',').map(&:to_i)
    selected_indexes.each do |index|
      selected_symptoms << symptoms[index - 1] if index >= 1 && index <= symptoms.length
    end
    puts "Select at least one symptom" if selected_symptoms.empty?
  end

  puts "You selected: #{selected_symptoms.join(", ")}"
  selected_symptoms.join(", ")
end

def input_pain_level
  puts "Please enter your pain level on a scale of 1 to 10:"
  pain_level = gets.chomp.to_i
  puts "Your pain level is: #{pain_level}"
  pain_level
end

def input_pain_start
  puts "Please describe when your pain started (in your own words):"
  gets.chomp
end

def list_symptoms
  puts "Please select the symptoms you're experiencing, by entering their
  corresponding index number:"
  SYMPTOMS.each_with_index do |symptom, index|
    puts "#{index + 1}. #{symptom}"
  end
end

# patient_letter("Could you write a letter to my GP saying I'm feeling pain, around
#   level 5, in my left arm, for the last 7 days. Started after a hike, I'm also
#   feeling tired and pounding headaches.")
