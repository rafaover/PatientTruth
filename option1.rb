require 'ruby/openai'

  private

API_KEY = "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"

# rubocop:disable Metric/MethodLength
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
# rubocop:enable Metric/MethodLength

patient_letter("Could you write a letter to my GP saying I'm feeling pain, around
  level 5, in my left arm, for the last 7 days. Started after a hike, I'm also
  feeling tired and pounding headaches.")
