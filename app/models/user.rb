class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :nickname, presence: true
  validates :password, format: { with: /\A(?=.*?[a-z])(?=.*?[\d])[a-z\d]+\z/i, message: 'は英字と数字の両方を使用してください' }

  with_options presence: true, format: { with: /\A[ぁ-んァ-ン一-龥]+\z/, message: 'には全角文字を使用してください' } do
    validates :first_name_kanji
    validates :last_name_kanji
  end
  with_options presence: true, format: { with: /\A[ァ-ン]+\z/, message: 'には全角カナを使用してください' } do
    validates :first_name_kana
    validates :last_name_kana
  end

  validates :birthday, presence: true
end
