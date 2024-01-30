require 'rails_helper'

require 'rails_helper'

RSpec.describe 'ラベルモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ラベルの名前が空文字の場合' do
      it 'バリデーションに失敗する' do
        label = Label.create(name: '')
        expect(label).not_to be_valid
      end
    end

    context 'ラベルの名前に値があった場合' do
      it 'バリデーションに成功する' do

        user = User.create!(name: 'a', email: 'a@gmail.com', password: 'password', password_confirmation: 'password', admin: false)

        label = Label.create(name: 'label_1', user: user)
        label.save
        expect(label).to be_valid

      end
    end
  end
end
