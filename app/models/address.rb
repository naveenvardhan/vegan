class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true
  
  def full_address
    [line_1, line_2, area, landmark, city].join(', ')
  end
end
