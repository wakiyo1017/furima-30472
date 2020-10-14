class Order < ApplicationRecord
  attr_accessor :token
  
  belongs_to :item
  belongs_to :user
  has_one :destination

  validates :token, presence: true
end
