json.extract! nora_repository, :id, :name, :url, :created_at, :updated_at
json.url nora_repository_url(nora_repository, format: :json)
