require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe '登録機能' do
    context 'ラベルを登録した場合' do
      before do
        visit new_session_path
        fill_in "session_email", with: "mystring@gmail.com"
        fill_in "session_password", with: "MyString"
        click_button "create-session"
      end
      it '登録したラベルが表示される' do
        find("a#new-label").click
        fill_in "label_name", with: "今日の仕事"
        click_button "create-label"

        expect(page).to have_content '今日の仕事'
      end
    end
  end
  describe '一覧表示機能' do
    let!(:user) {FactoryBot.create(:admin_user)}
    let!(:label) { FactoryBot.create(:label,user:user)}

    let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中",labels: [label], status: "未着手",user: user) }
    
    context '一覧画面に遷移した場合' do
      before do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password"
        click_button "create-session"
      end
      it '登録済みのラベル一覧が表示される' do

        click_link "labels-index"
        expect(page).to have_content 'ラベル1'
      end
    end
  end
end


