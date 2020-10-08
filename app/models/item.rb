class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :state
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :delivery_day

  belongs_to :user
  has_one_attached :image

  validates :price, presence: true, format: { with: /\A[0-9]+\z/, message: 'は半角数字を使用してください' }, numericality: { greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999 }
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :state, presence: true
  validates :region, presence: true
  validates :shipping_charge, presence: true
  validates :delivery_day, presence: true
  validates :category_id,  numericality: { other_than: 1 }
  validates :state_id, numericality: { other_than: 1 }
  validates :shipping_charge_id, numericality: { other_than: 1 }
  validates :region_id, numericality: { other_than: 1 }
  validates :delivery_day_id, numericality: { other_than: 1 }
  validates :image, presence: true
end