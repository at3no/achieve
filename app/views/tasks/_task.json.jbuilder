json.extract! task, :id, :user_id, :title, :content, :deadline, :charge_id, :done, :status, :user_id, :created_at, :updated_at
json.url task_url(task, format: :json)