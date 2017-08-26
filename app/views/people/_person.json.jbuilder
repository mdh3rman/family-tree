json.extract! person, :id, :name, :parentId, :relationshipType, :created_at, :updated_at
json.url person_url(person, format: :json)
