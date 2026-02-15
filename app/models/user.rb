class User < ApplicationRecord
  devise :database_authenticatable, 
         :recoverable, 
         :rememberable, 
         :validatable,
         :trackable

  enum role: {
    superadmin: "superadmin",
    warehouse_manager: "warehouse_manager",
    sales_manager: "sales_manager",
    customer_support: "customer_support",
    delivery_boy: "delivery_boy",
    helper: "helper"
  }

  validates :name, presence: true
  validates :phone, presence: true
  validates :role, presence: true
end

# User.create!(
#   name: "Naveen Admin",
#   phone: "8867836771",
#   email: "naveen@vegan.com",
#   password: "admin@123",
#   password_confirmation: "admin@123",
#   role: "superadmin"
# )
