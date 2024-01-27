class Task < ApplicationRecord
  belongs_to :user
  has_and_belongs_to_many :labels

  enum priority: { 低: 0, 中: 1, 高: 2 }
  enum status: { 未着手: 0, 着手中: 1, 完了: 2}
  
  validates :title, presence: {message: :blank}
  validates :content, presence: {message: :blank}
  validates :deadline_on, presence: {message: :blank}
  validates :priority, presence: {message: :blank}
  validates :status, presence: {message: :blank}



  scope :latest, -> { order(deadline_on: :asc, created_at: :desc) }
  scope :expensive, -> { order(priority: :desc, created_at: :desc) }
  scope :search_by_title, ->(title) { where("title LIKE ?", "%#{title}%") if title.present? }
  scope :search_by_status, ->(status) { where(status: status) if status.present? }
  scope :filtered_list, ->(params, current_user) do
    tasks = where(user_id: current_user.id)
    tasks = tasks.latest if params[:sort_deadline_on]
    tasks = tasks.expensive if params[:sort_priority]
    tasks = tasks.search_by_title(params[:search][:title]) if params[:search].present? && params[:search][:title].present?
    tasks = tasks.search_by_status(params[:search][:status]) if params[:search].present? && params[:search][:status].present?
    tasks.order(created_at: :desc)
  end
end
