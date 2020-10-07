class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new]

  def index
  end

  def new
    @item = Item.new
  end

  private
  def item_params
    params.require(:items).(:image, :name, :discription, :category_id, :state_id, :shipping_charge_id, :region_id, :delivery_days_id, :price).merge(user_id: current_user.id)
  end

end
