class Item < ApplicationRecord
  has_one_attached :image

  validates :name, :price, :category, presence: true

  VEG_IMAGES = {
    "Radish" => "radish.jpg",
    "Cucumber" => "cucumber.jpeg",
    "Green Turnip" => "kohlrabi.jpeg", # Kohlrabi is another name for Turnip/Navilukosu
    "Onion" => "onion.jpeg",
    "Potato" => "potato.jpg",
    "Ivy Gourd (Tondekayi)" => "ivy-gourd.jpeg",
    "Broccoli" => "broccolli.jpeg",
    "Cabbage" => "cabbage.jpg",
    "Sambar Cucumber" => "sambar-cucumber.jpeg",
    "Ladies Finger" => "ladies_finger.jpg",
    "Bottle Gourd" => "bottle-gourd.jpeg",
    "Ridge Gourd" => "ridge-guard.webp",
    "Carrot Nati (Big)" => "carrot-nati.jpg",
    "Carrot Ooty" => "OotyCarrot.webp",
    "Carrot Delhi / Red" => "carrot-delhi.webp",
    "Beetroot" => "beetroot.jpeg",
    "Capsicum" => "green-capsicum.jpg",
    "Beans Haricut" => "beans-haricot.jpg",
    "Beans Nati" => "beans_nati.webp",
    "Bitter Gourd" => "bitter-gourd.webp", # Check if Chikkadi matches your bitter-gourd image
    "Beans - Chikkadi Kai" => "Chikkadi-kai.jpg", # Check if Chikkadi matches your bitter-gourd image
    "Beans - Cow Pea" => "beans-cowpeas.webp",
    "Tomato Nati" => "tomato.jpeg",
    "Ginger" => "ginger.jpg",
    "Garlic" => "garlic.webp",
    "Green Chilli (Long)" => "chilli.jpg",
    "Green Chilli" => "chilli.jpg",
    "Green chilli small" => "chilli.jpg",
    "Bajji Chilli" => "bajji-chilli.jpeg",
    "Curry Leaves" => "Curryleaves.webp",
    "Seeme Badnekayi" => "chowchow.webp",
    "Green Peas" => "Green Peas.jpg",
    "Brinjal Small White" => "Brinjal-white.webp",
    "Brinjal Small Purple" => "brinjal-purple.jpeg",
    "Brinjal Bottle Black" => "brinjalbottleblack.jpg",
    "Brinjal Long Green" => "longbrinjal.jpg",
    "Ash Gourd (Boodu Kumbalakayi)" => "ash-guard.jpg",
    "Coconut" => "coconut.webp",
    "Lemon (Nimbe)" => "lemon.webp",
    "Coriander (Big)" => "Coriander Nati.png",
    "Fenugreek (Menthe)" => "methi-leaves.jpg",
    "Spinach (Palak)" => "Spinach.jpg",
    "Dill Leaves (Sabbakshi)" => "dil-leaves.webp",
    "Mint (Pudina)" => "pudina.jpeg",
    "Spring Onion" => "spring-onion.webp",
    "Cauliflower" => "cauli-flower.jpg",
    "Cluster Beans / Gorikayi" => "gorikayi.jpeg",
    "Arve soppu" => "arave-soppu.jpg",
    "Chilkarve" => "chilk-arve.png",
    "Chilkarve Soppu" => "chilk-arve.png",
    "Dhantu" => "dhantu.jpg",
    "Green peas" => "peas.jpeg",
    "Raw Banana / Bale Kai" => "banana_raw.jpg",
    "Avare Kai" => "avare-kai.jpeg",
    "Drumstick" => "drumstick.jpg",
    "Sweet Corn" => "sweet-corn.png",
    "Baby Corn" => "baby-corn.jpg",
    "Mushroom" => "mushroom.jpeg",
    "Tomato Hybrid / Seeds" => "tomato-hybrid.jpeg",
  }.freeze

  def image_path
    filename = VEG_IMAGES[name] || "placeholder.png"
    filename
  end

  def get_price(customer = nil)
    # binding.pry
    business_type = customer&.business_type || 'Hotels & Restaurants'
    if business_type == 'Seller'
      seller_price.to_i
    else
      price.to_i
    end
  end

  def self.price_map
    all.pluck(:id, :price).to_h
  end
end
