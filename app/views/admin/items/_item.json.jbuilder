json.extract! item, :id, :name, :category, :price, :quantity, :unit, :description, :image_url, :created_at, :updated_at
json.url item_url(item, format: :json)
