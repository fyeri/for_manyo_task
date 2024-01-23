class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password

  validates :name, presence: {message: :blank}
  validates :email, presence: true, uniqueness: { message: 'はすでに使用されています' }
  validates :password, presence: { message: 'を入力してください' }, length: { minimum: 6, message: 'は6文字以上で入力してください'  }
  before_validation { email.downcase! }
  validates_confirmation_of :password, {message: ''}


end
