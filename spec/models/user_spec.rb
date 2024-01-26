require 'rails_helper'

# RSpec.describe User, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end


RSpec.describe 'ユーザモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: '', email: 'user@gmail.com', password: "111111", password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'user', email: '', password: "111111", password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが空文字の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'user', email: 'user@gmile.com', password: "", password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのメールアドレスがすでに使用されていた場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'user', email: 'user@gmile.com', password: "", password_confirmation: '111111')

        user2 = User.create(name: 'user2', email: 'user@gmile.com', password: "111111", password_confirmation: '111111')
        expect(user).not_to be_valid
      end
    end

    context 'ユーザのパスワードが6文字未満の場合' do
      it 'バリデーションに失敗する' do
        user = User.create(name: 'user', email: 'user@gmile.com', password: "11111", password_confirmation: '11111')

        expect(user).not_to be_valid
      end
    end

    context 'ユーザの名前に値があり、メールアドレスが使われていない値で、かつパスワードが6文字以上の場合' do
      it 'バリデーションに成功する' do
        user = User.create(name: 'user', email: 'user@gmile.com', password: "111111", password_confirmation: '111111')

        expect(user).to be_valid
      end
    end
  end
end
