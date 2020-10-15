class OrderDestination
  include ActiveModel::Model

  attr_accessor :post_number, :region_id, :city, :street, :apartment, :telephone, :token, :user_id, :item_id

  with_options presence: true do
    validates :token
    validates :post_number, format: { with: /\A\d{3}[-]\d{4}\z/, message: 'を入力してください' }
    validates :region_id, numericality: { other_than: 1 , message: '都道府県を設定してください'}
    validates :city
    validates :street
    validates :telephone, format:{ with: /\d{10,11}/, message: 'はハイフン不要で、11桁以内で入力してください'}
  end
  
  
  def save
    @order = Order.create(user_id: user_id, item_id: item_id)
    Destination.create(post_number: post_number, region_id: region_id, city: city, street: street, apartment: apartment, telephone: telephone, order_id: @order.id)
  end
end
