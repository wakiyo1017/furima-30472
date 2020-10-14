class Destination < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :region

  belongs_to :order

  with_options presence: true do
    validates :post_number, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'を入力してください' }
    validates :region_id, numericality: { other_than: 1 , message: '都道府県を設定してください'}
    validates :city
    validates :street
    validates :telephone, format:{ with: /\d{10,11}/, message: 'はハイフン不要で、11桁以内で入力してください'}
  end
end
