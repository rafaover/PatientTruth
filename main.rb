# rubocop:disable Metric/MethodLength Metrics/AbcSize
# rubocop:disable Metrics/AbcSize
# rubocop:disable Style/StringLiterals
# rubocop:disable Style/StringLiteralsInInterpolation
# rubocop:disable Metrics/ClassLength

require 'ruby/openai'

class Model
  API_KEY = "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"
  SYMPTOMS = ["Headache", "Fever", "Fatigue", "Nausea", "Vomiting",
    "Chest pain", "Abdominal pain", "Joint pain", "Muscle pain", "Back pain",
    "Shortness of breath", "Cough", "Sore throat", "Runny nose", "Diarrhea",
    "Constipation", "Rash", "Numbness", "Tingling", "Blurred vision"]
  BODY_PARTS = ["Head", "Neck", "Shoulder", "Back", "Chest", "Abdomen", "Hips",
    "Thighs", "Knees", "Calves", "Ankles", "Feet", "Wrists", "Hands", "Elbows",
    "Arms", "Shoulders", "Stomach", "Groin"]

  def self.patient_letter(text)
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

  def self.select_gender
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

  def self.select_body_parts
    puts "Please select the body parts where you are feeling symptoms(use the corresponding number). When you're done
    write 'done':"

    BODY_PARTS.each_with_index do |part, index|
      puts "#{index + 1}. #{part}"
    end

    selected_body_parts = []
    while true
      user_input = gets.chomp
      break if user_input == "done"

      selected_body_part = BODY_PARTS[user_input.to_i - 1]
      selected_body_parts << selected_body_part if selected_body_part
    end
    selected_body_parts.join(", ")
  end

  def self.list_symptoms
    puts "Please select the symptoms you're experiencing, by entering their
    corresponding index number with a comma between it:"
    SYMPTOMS.each_with_index do |symptom, index|
      puts "#{index + 1}. #{symptom}"
    end
    puts " "
  end

  def self.select_symptoms
    list_symptoms
    selected_symptoms = []
    while selected_symptoms.empty?
      selected_indexes = gets.chomp.split(',').map(&:to_i)
      selected_indexes.each do |index|
        selected_symptoms << selected_indexes[index - 1] if index >= 1 && index <= selected_indexes.length
      end
      puts "Select at least one symptom" if selected_symptoms.empty?
    end

    puts "You selected: #{selected_symptoms.join(", ")}"
    selected_symptoms.join(", ")
  end

  def self.pain_presence
    puts "Are you feeling any type of pain? yes or no."
    gets.chomp.downcase
  end

  def self.body_parts_with_pain
    puts "Choose a part where you're feeling the most pain? When you're done write 'done':"

    BODY_PARTS.each_with_index do |part, index|
      puts "#{index + 1}. #{part}"
    end

    selected_body_parts = []
    while true
      user_input = gets.chomp
      break if user_input == "done"
    end

    selected_body_part = BODY_PARTS[user_input.to_i - 1]
    selected_body_parts << selected_body_part if selected_body_part
    selected_body_parts.join(", ")
  end

  def self.input_pain_level
    puts "Please enter your pain level on a scale of 1 to 10:"
    pain_level = gets.chomp.to_i
    puts "Your pain level is: #{pain_level}"
    pain_level
  end

  def self.input_pain_start
    puts "Please describe when your pain started (in your own words):"
    gets.chomp
  end

  def self.text_build_no_pain(symptoms, body_parts)
    "Could you write a document where I'm telling my GP that I have #{symptoms}, in my #{body_parts}."
  end

  def self.text_build_with_pain(
    symptoms,
    body_parts,
    pain_start,
    pain_level,
    body_pain
  )
    "Could you write a document where I'm telling my GP that I have #{symptoms}, in my #{body_parts}, pain started #{pain_start}, with pain level #{pain_level} in these body parts #{body_pain}."
  end
end
