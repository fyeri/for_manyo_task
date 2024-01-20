class Task < ApplicationRecord
  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2}
  
  validates :title, presence: {message: :blank}
  validates :content, presence: {message: :blank}
  validates :deadline_on, presence: {message: :blank}
  validates :priority, presence: {message: :blank}
  validates :status, presence: {message: :blank}

scope :latest, -> {order(deadline_on: :asc)}
scope :expensive, -> {order(priority: :desc)}
end
