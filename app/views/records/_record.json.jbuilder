json.extract! record, :id, :record_type, :host, :ttl, :content, :domain_id, :created_at, :updated_at
json.url record_url(record, format: :json)
