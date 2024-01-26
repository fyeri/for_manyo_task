class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  has_secure_password
  before_destroy :ensure_admin_remains
  before_update :check_admin_count
  before_validation { email.downcase! }

  validates :name, presence: {message: :blank}
  validates :email, presence: true, uniqueness: { message: 'はすでに使用されています' }
  validates :password, presence: { message: 'を入力してください' }, length: { minimum: 6, message: 'は6文字以上で入力してください'  }

  def admin?
    admin
  end

  def ensure_admin_remains
    if admin?
      if User.where(admin: true).count <= 1
      errors.add(:base, "管理者が0人になるため削除できません")
      throw(:abort)
      end
    end
  end

  def check_admin_count
    if admin_changed? && admin == false && User.where(admin: true).count <= 1
      errors.add(:base, "管理者が0人になるため権限を変更できません")
      throw(:abort)
    end
  end 
end
