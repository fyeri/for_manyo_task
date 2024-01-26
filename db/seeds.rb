# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: 'user1',
  email: 'user@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: false
)

admin = User.create(
  name: 'admin1',
  email: 'admin@gmail.com',
  password: 'password',
  password_confirmation: 'password',
  admin: true
)


50.times do |n|
  random_deadline = Date.today + rand(30)

  task = Task.new(
    title: "やることリスト#{n + 1}日目",
    content: "課題#{n + 1}個目",
    deadline_on: random_deadline,
    priority: Task.priorities.keys.sample,
    status: Task.statuses.keys.sample,
    user: user
  )
  task.save
end

50.times do |n|
  random_deadline = Date.today + rand(30)

  task = Task.new(
    title: "タスクリスト#{n + 1}日目",
    content: "テスト#{n + 1}個目",
    deadline_on: random_deadline,
    priority: Task.priorities.keys.sample,
    status: Task.statuses.keys.sample,
    user: admin
  )
  task.save
end
