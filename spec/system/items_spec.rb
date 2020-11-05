require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "新規出品", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item)
  end

  context "商品出品ができる時" do
    it "ログインしているユーザーは商品出品ができる" do 
      # ログインする
      basic_pass new_user_session_path
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 出品ボタンをクリックする
      expect(page).to have_content("出品する")
      # 商品出品ページに遷移する
      visit new_item_path
      # 商品の情報を入力する
      attach_file "item-image", "#{Rails.root}/app/assets/images/item-sample.png"
      ## 出品画像選択
      ## 商品名・商品の説明
      fill_in "item-name", with: @item.name
      fill_in "item-info", with: @item.description
      ## 商品詳細の選択
      select "メンズ", from: "item[category_id]"
      select "未使用に近い", from: "item[state_id]"
      ## 配送についての選択
      select "着払い（購入者負担）", from: "item[shipping_charge_id]"
      select "北海道", from: "item[region_id]"
      select "1〜2日で発送", from: "item[delivery_day_id]"
      ## 販売価格の入力
      fill_in "item-price", with: @item.price
      # 出品するのボタンを押すとitem modelのカウントが1増加する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(1)
      # トップページに遷移する
      expect(current_path).to eq root_path
    end
  end

  context "商品出品ができない時" do
    it "ログインしていないユーザーは商品出品ができない" do
      # ログインしていない時
      visit root_path
      # 出品ボタンを押すとログインページに遷移する
      click_link "新規投稿商品"
      expect(current_path).to eq new_user_session_path
    end
  end
end

RSpec.describe "商品編集", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context "商品詳細編集ができる時" do
    it "ログインしているユーザーは自分が投稿した商品の詳細を編集できる" do 
      # 商品1を出品したユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1の詳細ページに商品の編集ボタンがあることを確認する
      expect(page).to have_content("商品の編集")
      click_link "商品の編集"
      expect(current_path).to eq edit_item_path(@item1)
      # すでに出品済みの内容がフォームに入っていることを確認する
      expect(
        find('#item-name.items-text').value
      ).to eq @item1.name
      expect(
        find('#item-info.items-text').value
      ).to eq @item1.description
      expect(
        find('#item-category.select-box').value
      ).to eq "#{@item1.category_id}"
      expect(
        find('#item-sales-status.select-box').value
      ).to eq "#{@item1.state_id}"
      expect(
        find('#item-shipping-fee-status.select-box').value
      ).to eq "#{@item1.shipping_charge_id}"
      expect(
        find('#item-prefecture.select-box').value
      ).to eq "#{@item1.region_id}"
      expect(
        find('#item-scheduled-delivery.select-box').value
      ).to eq "#{@item1.delivery_day_id}"
      expect(
        find('#item-price.price-input').value
      ).to eq "#{@item1.price}"
      # 商品の情報を編集する
      ## 出品画像選択
      
      attach_file "item-image", "#{Rails.root}/app/assets/images/item-sample.png"
      ## 商品名・商品の説明
      fill_in "item-name", with: @item1.name
      fill_in "item-info", with: @item1.description
      ## 商品詳細の選択
      select "レディース", from: "item[category_id]"
      select "未使用に近い", from: "item[state_id]"
      ## 配送についての選択
      select "着払い（購入者負担）", from: "item[shipping_charge_id]"
      select "岩手県", from: "item[region_id]"
      select "1〜2日で発送", from: "item[delivery_day_id]"
      ## 販売価格の入力
      fill_in "item-price", with: @item1.price
      # 変更するのボタンを押してもitem modelのカウントが変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Item.count }.by(0)
      # 商品1の詳細ページに遷移したことを確認する
      expect(current_path).to eq item_path(@item1)
      # 商品1の詳細ページに変更した商品の内容が存在することを確認する（画像）
      expect(page).to have_selector("img[src$='item-sample.png']")
      # 商品1の詳細ページに変更した商品の内容が存在することを確認する（文字）
      expect(page).to have_content(@item1.name)
      expect(page).to have_content(@item1.description)
      expect(page).to have_content(@item1.category_id)
      expect(page).to have_content(@item1.state_id)
      expect(page).to have_content(@item1.shipping_charge_id)
      expect(page).to have_content(@item1.delivery_day_id)
      expect(page).to have_content(@item1.price)
    end
  end

  context "商品詳細編集ができない時" do
    it "ログインしたユーザーは自分以外が出品した商品の編集画面には遷移できない" do
      # 商品1を出品したユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の詳細画面に遷移する
      visit item_path(@item2)
      # 商品2の詳細画面に商品の編集ボタンがないことを確認する
      expect(page).to have_no_content "商品の編集"
    end
    it "ログインしていないユーザーは商品の編集画面には遷移できない" do
      # ログインしていない状態でトップページに遷移する
      basic_pass root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1の詳細ページに商品の編集ボタンがないことを確認する
      expect(page).to have_no_content "商品の編集"
      # トップページに遷移する
      visit root_path
      # 商品2の詳細ページに遷移する
      visit item_path(@item2)
      # 商品2の詳細ページに商品の編集ボタンがないことを確認する
      expect(page).to have_no_content "商品の編集"
    end
  end
end

RSpec.describe "商品削除", type: :system do
  before do
    @item1 = FactoryBot.create(:item)
    @item2 = FactoryBot.create(:item)
  end

  context "出品商品情報の削除ができる時" do
    it "ログインしているユーザーは自分が投稿した商品の詳細を削除できる" do 
      # 商品1を出品したユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1の詳細ページに商品の削除ボタンがあることを確認する
      expect(page).to have_content("削除")
      # 削除ボタンを押すとitem modelのレコードが1減ることを確認する
      expect{
        click_link "削除"
      }.to change { Item.count }.by(-1)
    end
  end

  context "商品情報が削除できない時" do
    it "ログインしたユーザーは自分以外が出品した商品情報を削除できない" do
      # 商品1を出品したユーザーでログインする
      basic_pass new_user_session_path
      fill_in "email", with: @item1.user.email
      fill_in "password", with: @item1.user.password
      find('input[name="commit"]').click
      expect(current_path).to eq root_path
      # 商品2の詳細画面に遷移する
      visit item_path(@item2)
      # 商品2の詳細画面に商品の削除ボタンがないことを確認する
      expect(page).to have_no_content "削除"
    end
    it "ログインしていないユーザーは商品の編集画面には遷移できない" do
      # ログインしていない状態でトップページに遷移する
      basic_pass root_path
      # 商品1の詳細ページに遷移する
      visit item_path(@item1)
      # 商品1の詳細ページに商品の削除ボタンがないことを確認する
      expect(page).to have_no_content "削除"
    end
  end
end
