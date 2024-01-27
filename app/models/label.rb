class Label < ApplicationRecord
  has_and_belongs_to_many :tasks

  validates :name, presence: {message: :blank}
end

