require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "OrderDestinations", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
    @order = FactoryBot.build(:order_destination)
  end

  context "商品購入ができる時" do
    it "ログインしているユーザーは自分以外が出品している商品を購入できる" do
      # 商品1を出品しているユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の詳細ページに遷移する
      visit item_path(@item2)
      # 購入画面に進むボタンをクリックすると購入画面に遷移する
      click_link "購入画面に進む"
      expect(current_path).to eq item_orders_path(@item2.id)
      # クレジットカード情報を入力する
      ## カード番号
      fill_in "card-number", with: "4242424242424242"
      ## 有効期限
      fill_in "card-exp-month", with: "12"
      fill_in "card-exp-year", with: "25"
      ## セキュリティコード
      fill_in "card-cvc", with: "123"
      # 配送先を入力する
      ## 郵便番号
      fill_in "postal-code", with: @order.post_number
      ## 県
      select "北海道", from: "order_destination[region_id]"
      ## 市区町村
      fill_in "city", with: @order.city
      ## 番地
      fill_in "addresses", with: @order.street
      ## 建物名
      fill_in "building", with: @order.apartment
      ## 電話番号
      fill_in "phone-number", with: @order.telephone
      # 購入ボタンを押すとorder modelと destination model のカウントが1増加することを確認する
      find('input[name="commit"]').click
      sleep(3)
      expect(Order.count).to eq 1
      expect(Destination.count).to eq 1
      # トップページに遷移していることを確認する
      expect(current_path).to eq root_path
    end
  end

  context "商品購入ができない時" do
    it "ログインしているユーザーは自分が出品している商品を購入できない" do
      # 商品1を出品しているユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品詳細ページに購入ボタンが無いことを確認する
      expect(page).to have_no_content("購入画面に進む")
    end
    
    it "ログインしていないユーザーは商品を購入できない" do
      # ログインしていない状態でトップページを表示する
      basic_pass new_user_session_path
      # 商品詳細ページに遷移する
      visit item_path(@item1)
      # 商品詳細ページに購入ボタンが無いことを確認する
      expect(page).to have_no_content("購入画面に進む")
    end
  end
end
