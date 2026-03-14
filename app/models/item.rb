class Item < ApplicationRecord
  # has_one_attached :image
  has_many :inventories

  GRADES = %w[A B].freeze
  SUB_CATEGORIES = ['Leafy', 'Fruiting', 'Gourds', 'Flowers', 'Beans and Peas', 'Roots', 'Bulbs', 'Others', 'Bags']
  UNITS = ['kg', 'pc', 'bag', 'box', 'gm', 'ltr']
  
  VEG_IMAGES = {
    # A
    "Radish" => "radish.jpg",
    "Cucumber" => "cucumber.jpeg",
    "Green Turnip" => "kohlrabi.jpeg",
    "Knol Khol" => "kohlrabi.jpeg",
    "Onion" => "onion.jpeg",
    "Potato" => "potato.jpg",
    "Ivy Gourd (Tondekayi)" => "ivy-gourd.jpeg",
    "Broccoli" => "broccolli.jpeg",
    "Cabbage" => "cabbage.jpg",
    "Cabbage local" => "cabbage.jpg",
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
    "Alsandekayi" => "beans-cowpeas.webp",
    "Tomato Nati" => "tomato.jpeg",
    "Ginger" => "ginger.jpg",
    "Garlic" => "garlic.webp",
    "Green Chilli (Long)" => "chilli.jpg",
    "Green Chilli" => "chilli.jpg",
    "Green chilli small" => "chilli.jpg",
    "Bajji Chilli" => "bajji-chilli.jpeg",
    "Curry Leaves" => "Curryleaves.webp",
    "Seeme Badnekayi" => "chowchow.webp",
    "Chow chow" => "chowchow.webp",
    "Green Peas" => "Green Peas.jpg",
    "Brinjal Small White" => "Brinjal-white.webp",
    "Brinjal (White round)" => "Brinjal-white.webp",
    "Brinjal Small Purple" => "brinjal-purple.jpeg",
    "Brinjal (Purple)" => "brinjal-purple.jpeg",
    "Brinjal Bottle Black" => "brinjalbottleblack.jpg",
    "Brinjal Long Green" => "longbrinjal.jpg",
    "Brinjal (Long Green)" => "longbrinjal.jpg",
    "Ash Gourd (Boodu Kumbalakayi)" => "ash-guard.jpg",
    "Ash Gourd" => "ash-guard.jpg",
    "Coconut" => "coconut.webp",
    "Lemon / Nimbe (Big)" => "lemon.webp",
    "Lemon (Nimbe)" => "lemon.webp",
    "Coriander (Big)" => "Coriander Nati.png",
    "Coriander Nati (Big)" => "Coriander Nati.png",
    "Fenugreek (Menthe)" => "methi-leaves.jpg",
    "Spinach (Palak)" => "Spinach.jpg",
    "Dill Leaves (Sabbakshi)" => "dil-leaves.webp",
    "Mint (Pudina)" => "pudina.jpeg",
    "Spring Onion" => "spring-onion.webp",
    "Cauliflower" => "cauli-flower.jpg",
    "Cluster Beans (Gorikayi)" => "gorikayi.jpeg",
    "Arve" => "arave-soppu.jpg",
    "Chilkarve" => "chilk-arve.png",
    "Chilkarve Soppu" => "chilk-arve.png",
    "Dhantu" => "dhantu.jpg",
    "Arvi" => "arvi.jpeg",
    "Green peas" => "peas.jpeg",
    "Raw Banana / Bale Kai" => "banana_raw.jpg",
    "Raw Banana" => "banana_raw.jpg",
    "Avare Kai" => "avare-kai.jpeg",
    "Drumstick" => "drumstick.jpg",
    "Sweet Corn" => "sweet-corn.png",
    "Baby Corn" => "baby-corn.jpg",
    "Mushroom" => "mushroom.jpeg",
    "Tomato Hybrid / Seeds" => "tomato-hybrid.jpeg",
    
    # B
    "Cluster Beans (Gorikayi) | Grade B" => "gorikayi.jpeg",
    "Capsicum grade B" => "green-capsicum.jpg",
    # Bags
    "Tomato Nati A(22kg)" => "tomato-20-a.jpg",
    "Tomato Hybrid / Seeds A(22kg)" => "tomato-hybrid.jpeg",
    "Tomato Hybrid / Seeds A(12kg)" => "tomato-hybrid.jpeg",
    "Capsicum A(25kg)" => "green-capsicum.jpg",
    "Radish A (18kg)" => "radish-A.jpg",
    "" => "",
  }.freeze
  
  validates :name, presence: true
  validates :grade, inclusion: { in: GRADES }#, allow_nil: true

  scope :for_seller, -> { where(show_for_seller: true) }
  scope :for_hotel, -> { where(show_for_hotel: true) }
  scope :by_grade, ->(grade) { where(grade: grade) if grade.present? }

  def image_path
    filename = VEG_IMAGES[name] || "placeholder.png"
    filename
  end

  def get_price(is_seller = false)
    # binding.pry
    
    # business_type = customer&.business_type || 'Hotels & Restaurants'
    if is_seller
      seller_price.to_i
    else
      price.to_i
    end
  end
  
  def get_description(is_seller = false)
    if is_seller
      seller_remarks.to_s
    else
      description.to_s
    end
  end

  def self.price_map
    all.pluck(:id, :price).to_h
  end

  def total_available_stock
    inventories.sum(:remaining_quantity)
  end

  def out_of_stock?
    total_available_stock <= 0
  end

end
