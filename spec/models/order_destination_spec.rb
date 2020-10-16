require 'rails_helper'

RSpec.describe OrderDestination, type: :model do
  before do
    @order = FactoryBot.build(:order_destination)
  end
  context '購入処理がうまくいく時' do
    it "カード情報が全て正確に入力され、郵便番号、都道府県、市町村、番地、建物名、電話番号が正確に入力されていれば購入処理ができる" do
      expect(@order).to be_valid
    end
    it "建物名は入力されていなくても購入処理ができる" do
      @order.apartment = nil
      expect(@order).to be_valid
    end
  end

  context '購入処理がうまく行かない時' do
    it "カード情報が正しく入力され、tokenが生成されなければ購入処理がされない" do
      @order.token = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Token can't be blank")
    end
      it "郵便番号がなければ購入処理ができない" do
      @order.post_number = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Post number can't be blank", "Post number をハイフンを使い正しく入力してください")
    end
    it "郵便番号がハイフンを使用し000-0000の形でなければ購入処理ができない" do
      @order.post_number = "123456"
      @order.valid?
      expect(@order.errors.full_messages).to include("Post number をハイフンを使い正しく入力してください")
    end
    it "都道府県がなければ購入処理ができない" do
      @order.region_id = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Region can't be blank", "Region 都道府県を設定してください")
    end
    it "都道府県が正しく選択(category_idが1以外)でなければ購入処理ができない" do
      @order.region_id = 1
      @order.valid?
      expect(@order.errors.full_messages).to include("Region 都道府県を設定してください")
    end
    it "市区町村が入力されていなければ購入処理ができない" do
      @order.city = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("City can't be blank")
    end
    it "番地が入力されていなければ購入処理ができない" do
      @order.street = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Street can't be blank")
    end
    it "電話番号が入力されていないと購入処理ができない" do
      @order.telephone = nil
      @order.valid?
      expect(@order.errors.full_messages).to include("Telephone can't be blank")
    end
    it "電話番号は10桁もしくは11桁のハイフンなしの数字でなければ登録できない" do
      @order.telephone = "012345"
      @order.valid?
      expect(@order.errors.full_messages).to include("Telephone はハイフン不要で、11桁以内で入力してください")
    end
    it "電話番号はハイフンがあると登録できない" do
      @order.telephone = "012-1234-1234"
      @order.valid?
      expect(@order.errors.full_messages).to include("Telephone はハイフン不要で、11桁以内で入力してください")
    end
  end
end
