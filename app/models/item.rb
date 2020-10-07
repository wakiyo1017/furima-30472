class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category, :state, :region, :shipping_charge, :delivery_days

  belongs_to :user


  validates :price, presence: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, format:{ with: /\A[0-9]+z\/, message: 'は半角数字を使用してください' }
  validates :name, :description, :category, :state, :region, :shipping_charge, :delivery_days, presence: true
  validates :category_id, :state_id, :shipping_charge_id, :region_id, :delivery_days_id, numericality: { other_than: 1 }

end
