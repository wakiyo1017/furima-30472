require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    before do
      @user = FactoryBot.build(:user)
    end
    it "nickname,email,password,password_confirmation,first_name_kanji,last_name_kanji,first_name_kana,last_name_kana,birthdayの全てが存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "nicknameが空だと登録できない" do
      @user.nickname = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Nickname can't be blank")
    end
    it "emailが空だと登録できない" do
      @user.email = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "emailに@が含まれないと登録できない" do
      user = FactoryBot.build(:user, email: "mmmnnnnnn")
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
    it "passwordが空だと登録できない" do
      @user.password = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "passwordが数字のみだと登録できない" do
      user = FactoryBot.build(:user, password: "000000")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字の両方を使用してください")
    end
    it "passwordが英字のみだと登録できない" do
      user = FactoryBot.build(:user, password: "pppppp")
      user.valid?
      expect(user.errors[:password]).to include("は英字と数字の両方を使用してください")
    end
    it "passwordが6文字より少ないと登録できない" do
      user = FactoryBot.build(:user, password: "p1234")
      user.valid?
      expect(user.errors[:password]).to include("is too short (minimum is 6 characters)")
    end
    it "passwordと確認用passwordが一致していないと登録できない" do
      user = FactoryBot.build(:user, password: "p12345")
      user = FactoryBot.build(:user, password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("doesn't match Password")
    end
    it "birthdayが空だと登録できない" do
      @user.birthday = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Birthday can't be blank")
    end
    it "first_name_kanjiが空だと登録できない" do
      @user.first_name_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kanji can't be blank")
    end
    it "first_name_kanjiが空だと登録できない" do
      @user.last_name_kanji = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kanji can't be blank")
    end
    it "first_name_kanaが空だと登録できない" do
      @user.first_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("First name kana can't be blank")
    end
    it "last_name_kanaが空だと登録できない" do
      @user.last_name_kana = nil
      @user.valid?
      expect(@user.errors.full_messages).to include("Last name kana can't be blank")
    end
    it "first_name_kanjiが全角文字でないと登録できない" do
      user = FactoryBot.build(:user, first_name_kanji: "kanji")
      user.valid?
      expect(user.errors[:first_name_kanji]).to include("には全角文字を使用してください")
    end
    it "last_name_kanjiが全角文字でないと登録できない" do
      user = FactoryBot.build(:user, last_name_kanji: "kanji")
      user.valid?
      expect(user.errors[:last_name_kanji]).to include("には全角文字を使用してください")
    end
    it "first_name_kanaが全角カナでないと登録できない" do
      user = FactoryBot.build(:user, first_name_kana: "kana")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("には全角カナを使用してください")
    end
    it "last_name_kanaが全角カナでないと登録できない" do
      user = FactoryBot.build(:user, last_name_kana: "kana")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("には全角カナを使用してください")
    end
    it "重複したemailが存在する場合登録できない" do
      @user.save
      another_user = FactoryBot.build(:user)
      another_user.email = @user.email
      another_user.valid?
      expect(another_user.errors.full_messages).to include("Email has already been taken")
    end
  end
end
