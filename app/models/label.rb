class Label < ApplicationRecord
  belongs_to :user
  has_many :label_tasks, dependent: :destroy
  has_many :tasks, through: :label_tasks


  validates :name, presence: {message: :blank}
end

