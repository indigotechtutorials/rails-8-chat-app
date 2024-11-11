class AiResponseJob < ApplicationJob
  queue_as :default

  def perform(message_id)
    message = Message.find(message_id)
    chat = message.chat
    client = Ollama.new(
      credentials: { address: 'http://localhost:11434' },
      options: { server_sent_events: true }
    )

    result = client.generate(
      { model: 'llama3.2',
        prompt: "Please respond to this chat message with your opionions #{message.body}" }
    )
    ai_response = result.map { |r| r['response'] }.join
    
    chat.messages.create(body: ai_response, from_user: "llama3.2")
  end
end
