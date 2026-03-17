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
    "Beetroot A" => "beetroot.jpeg",
    "Capsicum" => "green-capsicum.jpg",
    "Beans Haricot" => "beans-haricot.jpg",
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
    "Brinjal round white" => "Brinjal-white.webp",
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
    "Drumstick B" => "drumstick.jpg",
    "Sweet Corn" => "sweet-corn.png",
    "Baby Corn" => "baby-corn.jpg",
    "Mushroom" => "mushroom.jpeg",
    "Tomato Hybrid / Seeds" => "tomato-hybrid.jpeg",

    # B
    "Gorikayi B" => "gorikayi.jpeg",
    "Capsicum B" => "green-capsicum.jpg",
    "Onion B" => "onion.jpeg",
    "Garlic B" => "garlic-b.jpg",
    "Garlic Medium B" => "garlic-b.jpg",
    "Bringal long B" => "longbrinjal.jpg",
    "Sambar cucumber B" => "sambar-cucumber.jpeg",
    "Ladies finger B"  => "ladies_finger.jpg",
    "Green chilli B" => "green-chilli-b.jpg",
    "Tondekayi B" => "ivy-gourd.jpeg",
    "Bajji chilli B" => "bajji-chilli.jpeg",
    "Tomato Hybrid B" => "tomato-hybrid-b.webp",
    "Tomato Nati B" => "nati-tomato-b.jpeg",
    "Cucumber B" => "cucumber.jpeg",
    "Ridge gourd B" => "ridge-gourd-b.jpg",
    "Chow chow B" => "chowchow.webp",
    "Bottle gourd B" => "bottle-gourd.jpeg",
    "Beans haricot B" => "haricot-beans-b.jpg",
    "Beans nati B" => "beans_nati.png",
    "Green peas B" => "peas.jpeg",
    "Potato B" => "potato-b.jpg",
    "Carrot nati B" => "carrot-nati.jpg",
    "Carrot ooty B" => "carrot-ooty.jpg",
    "Knol Khol B" => "knol-kol-b.jpg",
    "Radish B" => "radish-b.jpg",
    "Beetroot B" => "beetroot-b.jpg",
    "Ginger B" => "ginger-b.jpg",

    # Bags
    "Tomato Nati A(22kg)" => "tomato-20-a.jpg",
    "Tomato Hybrid / Seeds A(22kg)" => "tomato-hybrid.jpeg",
    "Tomato Hybrid / Seeds A(12kg)" => "tomato-hybrid.jpeg",
    "Capsicum A(25kg)" => "green-capsicum.jpg",
    "Radish A (18kg)" => "radish-A.jpg",
    "Brinjal purple A (15kg)" => "brinjal-purple.jpg",
    "Brinjal round A (15kg)" => "brinjal-white-round.jpg",
    "Brinjal white long(15kg)" => "brinjal-white.jpg",
    "Onion A (50kg)" => "Onion-A.jpg",
    "Onion A (20kg)" => "onion-bag-20.jpg",
    "Onion B (50kg)" => "Onion-B.jpg",
    "Potato A (50kg)" => "Potato-A.jpg",
    "Potato B (50kg)" => "potato-b.jpeg",
    "Garlic Big A (30kg)" => "garlic-big.jpg",
    "Garlic Medium A (30kg)" => "garlic-med.jpg",
    "Beetroot A(20kg)" => "beetroot-bag.jpg",
    "Beans nati A(60kg)" => "beans_nati.webp",
    "Beans haricot A(60kg)" => "beans-haricot.jpg",
    "Carrot nati A(60kg)" => "carrot-nati-bag.jpg",
    "Carrot nati A(20kg)" => "carrot-nati-bag.jpg",
    "Chow chow A(20kg)" => "chow-chow-a.jpg",
    "Green chilli A (60kg)" => "chilli.jpg",
    "Cauliflower A (15pc)" => "cauli-flower.jpg",
    "Beetroot A(50kg)" => "beetroot-bag.jpg",
    "Green chilli long(60kg)" => "chilli.jpg",
    "Cucumber A(45kg)" => "cucumber-A.jpg",
    "Ginger A(60kg)" => "ginger.jpg",
    "Bajji chilli A(20kg)" => "bajji-chilli-a.jpg",
    "Carrot ooty A(85kg)" => "carrot-ooty.jpg",
    "Knol Khol A(50kg)" => "kohlrabi.jpeg",
    "Green peas A(60kg)" => "peas.jpeg",
    "Cabbage local (45kg)" => "cabbage.jpg",
    "Ridge gourd A (20kg)" => "ridge-guard.webp",
    "Bitter gourd A(20kg)" => "bitter-gourd-a.jpg",
    "Bitter gourd B(20kg)" => "bitter-b.jpg",
    "Bottle gourd A(20kg)" => "bottle-gourd.jpeg",
    "Cucumber A (20kg)" => "cucumber-A.jpg"
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
