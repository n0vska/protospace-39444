class User < ApplicationRecord
  has_many :prototypes
  has_many :comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
   # ユーザー名、プロフィール、所属、役職が空では保存できないというバリデーション
   validates :name, presence: true
   validates :profile, presence: true
   validates :occupation, presence: true
   validates :position, presence: true
end
