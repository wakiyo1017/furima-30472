class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :state
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :delivery_day

  belongs_to :user
  has_one_attached :image
  has_one :order

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'は半角数字で300円から9,999,999円の間で設定してください' }
  
  with_options presence: true do
    validates :name, :description, :category, :state, :region, :shipping_charge, :delivery_day
  end
  validates :category_id,  numericality: { other_than: 1 , message: 'を設定してください'}
  validates :state_id, numericality: { other_than: 1 , message: 'を設定してください'}
  validates :shipping_charge_id, numericality: { other_than: 1 , message: 'を設定してください'}
  validates :region_id, numericality: { other_than: 1 , message: 'を設定してください'}
  validates :delivery_day_id, numericality: { other_than: 1 , message: 'を設定してください'}
  validates :image, presence: true
end