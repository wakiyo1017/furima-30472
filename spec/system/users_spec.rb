require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe "Users", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  context "ユーザー新規登録ができる時" do
    it "正しい情報を入力するとユーザー新規登録ができて、トップページに移動する" do
      # トップページに移動する
      basic_pass root_path
      # トップページにサインアップページに移動するためのボタン(新規登録ボタン）があることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: @user.nickname
      fill_in "email", with: @user.email
      fill_in "password", with: @user.password
      fill_in "password-confirmation", with: @user.password_confirmation
      fill_in "first-name", with: @user.first_name_kanji
      fill_in "last-name", with: @user.last_name_kanji
      fill_in "first-name-kana", with: @user.first_name_kana
      fill_in "last-name-kana", with: @user.last_name_kana
      # 誕生日情報を入力する
      select "1980", from: "user[birthday(1i)]"
      select "10", from: "user[birthday(2i)]"
      select "17", from: "user[birthday(3i)]"
      # 会員登録ボタンを押すとユーザーモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(1)
      # トップページ移動する
      expect(current_path).to eq root_path
      # トップページにログアウトボタンが表示されていることを確認する
      expect(page).to have_content("ログアウト")
      # 新規登録するためのボタンや、ログインページに移動するためのボタンが表示されていないことを確認する
      expect(page).to have_no_content("ログイン")
      expect(page).to have_no_content("新規登録")
    end
  end
  context "ユーザー新規登録ができない時" do
    it "誤った情報を入力するとユーザー新規登録ができず、新規登録ページに戻ってくる" do
      # トップページに移動する
      visit root_path
      # トップページにサインアップページに移動するためのボタン(新規登録ボタン）があることを確認する
      expect(page).to have_content("新規登録")
      # 新規登録ページに移動する
      visit new_user_registration_path
      # ユーザー情報を入力する
      fill_in "nickname", with: ""
      fill_in "email", with: ""
      fill_in "password", with: ""
      fill_in "password-confirmation", with: ""
      fill_in "first-name", with: ""
      fill_in "last-name", with: ""
      fill_in "first-name-kana", with: ""
      fill_in "last-name-kana", with: ""
      # 誕生日情報を入力する
      select "--", from: "user[birthday(1i)]"
      select "--", from: "user[birthday(2i)]"
      select "--", from: "user[birthday(3i)]"
      # サインアップのボタンを押してもユーザーモデルのカウントが上がらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { User.count }.by(0)
      # 登録ページに戻ることを確認する
      expect(current_path).to eq "/users"
    end
  end
end
