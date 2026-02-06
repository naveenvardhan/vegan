namespace :db do
  desc "Seed the Item table with farm-to-customer products"
  task setup_items: :environment do
    items_list = [
      # Vegetables by KG
      { name: "Radish", category: "vegetables", price: 15, mrp: 20, unit: "kg" },
      { name: "Cucumber", category: "vegetables", price: 19, mrp: 25, unit: "kg" },
      { name: "Green Turnip", category: "vegetables", price: 28, mrp: 35, unit: "kg" },
      { name: "Onion", category: "vegetables", price: 25, mrp: 35, unit: "kg" },
      { name: "Potato", category: "vegetables", price: 19, mrp: 30, unit: "kg" },
      { name: "Ivy Gourd (Tondekayi)", category: "vegetables", price: 49, mrp: 60, unit: "kg" },
      { name: "Broccoli", category: "vegetables", price: 79, mrp: 100, unit: "kg" },
      { name: "Cabbage", category: "vegetables", price: 22, mrp: 30, unit: "kg" },
      { name: "Sambar Cucumber", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Ladies Finger", category: "vegetables", price: 36, mrp: 45, unit: "kg" },
      { name: "Bottle Gourd", category: "vegetables", price: 26, mrp: 35, unit: "kg" },
      { name: "Ridge Gourd", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Carrot Nati (Big)", category: "vegetables", price: 43, mrp: 55, unit: "kg" },
      { name: "Carrot Ooty", category: "vegetables", price: 38, mrp: 50, unit: "kg" },
      { name: "Carrot Delhi / Red", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Beetroot", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Capsicum", category: "vegetables", price: 41, mrp: 55, unit: "kg" },
      { name: "Beans Haricut", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Beans Nati", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Beans - Chikkadi Kai", category: "vegetables", price: 49, mrp: 65, unit: "kg" },
      { name: "Beans - Cow Pea", category: "vegetables", price: 59, mrp: 75, unit: "kg" },
      { name: "Tomato Nati", category: "vegetables", price: 44, mrp: 55, unit: "kg" },
      { name: "Ginger", category: "vegetables", price: 59, mrp: 80, unit: "kg", description: "Above 1kg price" },
      { name: "Garlic", category: "vegetables", price: 169, mrp: 200, unit: "kg", description: "Above 1kg price" },
      { name: "Green Chilli", category: "vegetables", price: 64, mrp: 80, unit: "kg" },
      { name: "Bajji Chilli", category: "vegetables", price: 59, mrp: 75, unit: "kg" },
      { name: "Curry Leaves", category: "vegetables", price: 69, mrp: 85, unit: "kg" },
      { name: "Seeme Badnekayi", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Green Peas", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Brinjal Small White", category: "vegetables", price: 15, mrp: 25, unit: "kg" },
      { name: "Brinjal Small Purple", category: "vegetables", price: 19, mrp: 30, unit: "kg" },
      { name: "Brinjal Bottle Black", category: "vegetables", price: 35, mrp: 45, unit: "kg" },
      { name: "Brinjal Long Green", category: "vegetables", price: 24, mrp: 35, unit: "kg" },
      { name: "Ash Gourd (Boodu Kumbalakayi)", category: "vegetables", price: 39, mrp: 50, unit: "kg" },
      { name: "Coconut", category: "grocery", price: 76, mrp: 90, unit: "kg" },

      # Items by Piece (pc)
      { name: "Lemon (Nimbe)", category: "vegetables", price: 3, mrp: 5, unit: "pc" },
      { name: "Coriander (Big)", category: "vegetables", price: 15, mrp: 20, unit: "pc" },
      { name: "Fenugreek (Menthe)", category: "vegetables", price: 15, mrp: 20, unit: "pc" },
      { name: "Spinach (Palak)", category: "vegetables", price: 15, mrp: 20, unit: "pc" },
      { name: "Dill Leaves (Sabbakshi)", category: "vegetables", price: 15, mrp: 20, unit: "pc" },
      { name: "Mint (Pudina)", category: "vegetables", price: 15, mrp: 20, unit: "pc" },
      { name: "Spring Onion", category: "vegetables", price: 19, mrp: 25, unit: "pc" },
      { name: "Cauliflower", category: "vegetables", price: 29, mrp: 40, unit: "pc" }
    ]

    puts "Seeding items into the database..."

    items_list.each do |data|
      item = Item.find_or_create_by!(name: data[:name]) do |i|
        i.category = data[:category]
        i.price = data[:price]
        i.mrp = data[:mrp]
        i.unit = data[:unit]
        i.quantity = "1" # Base quantity unit
        i.description = data[:description]
      end
      puts "Processed: #{item.name}"
    end

    puts "Successfully synced #{items_list.count} items."
  end
end