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
    "Male"
  when 2
    "Female"
  when 3
    "Other"
  else
    "Invalid selection. Please select 1, 2, or 3."
  end
end

def selecting_body_part
  body_parts = %w(Head Neck Chest LeftArm RightArm RightLeg LeftLeg Eyes )

  puts "Please select a body part:"

  body_parts.each_with_index do |body_part, index|
    puts "#{index + 1}. #{body_part}"
  end
  body_part_choice = gets.chomp.to_i

  if (1..body_parts.length).cover?(body_part_choice)
    selected_body_part = body_parts[body_part_choice - 1]
    puts "You selected: #{selected_body_part}"
  else
    puts "Invalid selection. Please try again."
  end

  selected_body_part
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

# patient_letter("Could you write a letter to my GP saying I'm feeling pain, around
#   level 5, in my left arm, for the last 7 days. Started after a hike, I'm also
#   feeling tired and pounding headaches.")
