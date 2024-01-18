class Task < ApplicationRecord

  validates :title, presence: {message: 'を入力してください'}
  validates :content, presence: {message: 'を入力してください'}
end
