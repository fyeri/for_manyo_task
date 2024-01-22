# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Task.destroy_all

# Seed data
tasks_data = [
  { title: 'first_task', content: 'Task content 1', deadline_on: '2025-02-18', priority: '中', status: '未着手' },
  { title: 'second_task', content: 'Task content 2', deadline_on: '2025-02-17', priority: '高', status: '着手中' },
  { title: 'third_task', content: 'Task content 3', deadline_on: '2025-02-16', priority: '低', status: '完了' },
  { title: 'fourth_task', content: 'Task content 4', deadline_on: '2025-02-15', priority: '中', status: '未着手' },
  { title: 'fifth_task', content: 'Task content 5', deadline_on: '2025-02-14', priority: '高', status: '着手中' },
  { title: 'sixth_task', content: 'Task content 6', deadline_on: '2025-02-13', priority: '低', status: '完了' },
  { title: 'seventh_task', content: 'Task content 7', deadline_on: '2025-02-12', priority: '中', status: '未着手' },
  { title: 'eighth_task', content: 'Task content 8', deadline_on: '2025-02-11', priority: '高', status: '着手中' },
  { title: 'ninth_task', content: 'Task content 9', deadline_on: '2025-02-10', priority: '低', status: '完了' },
  { title: 'tenth_task', content: 'Task content 10', deadline_on: '2025-02-09', priority: '中', status: '未着手' }
]

tasks_data.each do |task_data|
  Task.create!(task_data)

end