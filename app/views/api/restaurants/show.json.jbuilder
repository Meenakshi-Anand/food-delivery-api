json.menu do
  @menu.each do |food_item|
    json.set! food_item.id do
      json.extract! food_item, :name, :price
    end
  end
end
