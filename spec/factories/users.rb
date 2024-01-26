FactoryBot.define do
  factory :user do
    name { "MyString" }
    email { "mystring@gmail.com" }
    password { "MyString" }
    password_confirmation { "MyString" }
    admin { false }
  end

  factory :admin_user, class: User do
    name { 'a' }
    email { 'a@gmail.com' }
    password { 'password' }
    password_confirmation { 'password' }
    admin { true }
  end
end
