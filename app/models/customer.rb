# app/models/customer.rb
class Customer < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :rememberable, authentication_keys: [:phone]

  has_many :addresses, as: :addressable, dependent: :destroy

  # Mandatory Fields
  validates :name, :phone, :business_name, :business_type, presence: true
  validates :phone, presence: true, uniqueness: true, numericality: { only_integer: true },length: { is: 10, message: "must be exactly 10 digits" }

  before_validation :generate_credentials, on: :create
  
  def update_default_address(add_id)
    self.addresses.where.not(id: add_id).update_all(is_default: false)
  end

  private

  def generate_credentials
    # Create a dummy email: phone@veganfarm.com
    user_name = name.downcase.gsub(' ', '.')
    # self.user_name = name.downcase.gsub(' ', '_')
    self.email = "#{user_name.gsub(/\s+/, '')}@gmail.com" # if email.blank? && phone.present?
    
    # Set password to phone number if not provided
    if password.blank? && phone.present?
      self.password = phone
      self.password_confirmation = phone
    end
  end

  # Allow Devise to login using phone (we will configure this next)
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (phone = conditions.delete(:phone))
      where(conditions.to_h).where(["phone = :value", { value: phone }]).first
    else
      where(conditions.to_h).first
    end
  end
  
end