json.extract! message, :id, :chat_id, :body, :from_user, :created_at, :updated_at
json.url message_url(message, format: :json)
