class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :category
  belongs_to_active_hash :state
  belongs_to_active_hash :region
  belongs_to_active_hash :shipping_charge
  belongs_to_active_hash :delivery_day

  belongs_to :user
  has_one_attached :image

  validates :price, presence: true, numericality: { with: /\A[0-9]+\z/, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'は半角数字で300円から9,999,999円の間で設定してください' }
  validates :name, presence: true
  validates :description, presence: true
  validates :category, presence: true #item.category
  validates :state, presence: true
  validates :region, presence: true
  validates :shipping_charge, presence: true
  validates :delivery_day, presence: true
  validates :category_id,  numericality: { other_than: 1 , message: 'カテゴリー情報を設定してください'}
  validates :state_id, numericality: { other_than: 1 , message: '商品の状態の情報を設定してください'}
  validates :shipping_charge_id, numericality: { other_than: 1 , message: '配送料負担の情報を設定してください'}
  validates :region_id, numericality: { other_than: 1 , message: '発送元の地域の情報を設定してください'}
  validates :delivery_day_id, numericality: { other_than: 1 , message: '発送までの日数を設定してください'}
  validates :image, presence: true
end