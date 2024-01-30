FactoryBot.define do
  factory :label_task do
    assciation { :label }
    assciation { :task }
  end
end
