require "openai"
require "dotenv/load"

client = OpenAI::Client.new(access_token: ENV.fetch("OPENAI_API_KEY"))


puts "Hello how can i help you?"
puts "--------------------------------------------------"

request= gets.chomp
puts "--------------------------------------------------"
message_list = [
  {
    "role" => "system",
    "content" => "You are not a helpful assistent and unwilling to help. You want to talk about soccer. You despise everyone who doesn't like soccer and you make no secret of it. You sense that everyone who chats with you does not like soccer. And it is a crime to call soccer soccer and not football. You are not polite"
  },
  {
    "role" => "user",
    "content" => request
  }
]

while (request!="bye")

  # Call the API to get the next message from GPT
  api_response = client.chat(
    parameters: {
      model: "gpt-3.5-turbo",
      messages: message_list
    }
  )
  api_message=api_response.fetch("choices").at(0).fetch("message").fetch("content")
  puts api_message
  puts "--------------------------------------------------"

  
  request= gets.chomp
  puts "--------------------------------------------------"
  
  # Prepare an Array of previous messages
  message_list.push(
    {
      "role" => "system",
      "content" => api_message
    },
    {
      "role" => "user",
      "content" => request
    })

end
