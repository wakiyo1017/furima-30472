require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品新規登録' do
    before do
      @item = FactoryBot.build(:item)
    end

    it "画像、商品名、説明文、カテゴリー、状態、配送料、発送元、日数、価格の情報があれば登録できる" do
      expect(@item).to be_valid
    end
    it "画像の添付がないと登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")  
    end
    it "商品名がないと登録できない" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end
    it "説明文がないと登録できない" do
      @item.description = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Description can't be blank")
    end
    it "カテゴリー情報がない(選択されていない※category_idが1である)と登録できない" do
      @item.category_id = 1
      @item.valid?
      expect(@item.errors[:category_id]).to include("カテゴリー情報を設定してください")
    end
    it "商品の状態の情報がない(選択されていない※state_idが1である)と登録できない" do
      @item.state_id = 1
      @item.valid?
      expect(@item.errors[:state_id]).to include("商品の状態の情報を設定してください")
    end
    it "配送料の負担の情報がない(選択されていない※shipping_charge_idが1である)と登録できない" do
      @item.shipping_charge_id = 1
      @item.valid?
      expect(@item.errors[:shipping_charge_id]).to include("配送料負担の情報を設定してください")
    end
    it "発送元の地域の情報がない(選択されていない※region_idが1である)と登録できない" do
      @item.region_id = 1
      @item.valid?
      expect(@item.errors[:region_id]).to include("発送元の地域の情報を設定してください")
    end
    it "発送までの日数がない(選択されていない※delivery_day_idが1である)と登録できない" do
      @item.delivery_day_id = 1
      @item.valid?
      expect(@item.errors[:delivery_day_id]).to include("発送までの日数を設定してください")
    end
    it "価格についての情報がないと登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end
    it "価格が300円未満であると登録できない" do
      @item.price = 299
      @item.valid?
      expect(@item.errors[:price]).to include("は半角数字で300円から9,999,999円の間で設定してください")
    end
    it "価格が10,000,000円以上であると登録できない" do
      @item.price = 10000000
      @item.valid?
      expect(@item.errors[:price]).to include("は半角数字で300円から9,999,999円の間で設定してください")
    end
    it "価格が半角数字以外であると登録できない" do
      @item.price = "文字列"
      @item.valid?
      expect(@item.errors[:price]).to include("は半角数字で300円から9,999,999円の間で設定してください")
    end

  end
end
