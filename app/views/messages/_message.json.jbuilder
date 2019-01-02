json.extract! message, :id, :msg, :user, :created_at, :updated_at
json.url message_url(message, format: :json)
