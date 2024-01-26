require 'rails_helper'

RSpec.describe 'ユーザ管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:admin_user) { FactoryBot.create(:admin_user) }

  describe '登録機能' do
    context 'ユーザを登録した場合' do
      it 'タスク一覧画面に遷移する' do
        visit new_session_path

        click_link "sign-up"
        fill_in "user_name", with: "user"
        fill_in "user_email", with: "user@gmail.com" 
        fill_in "user_password", with: "password"
        fill_in "user_password_confirmation", with: "password"
        click_button "create-user"

        expect(page).to have_content('タスク一覧ページ')
      end
    end

    context 'ログインせずにタスク一覧画面に遷移した場合' do
      it 'ログイン画面に遷移し、「ログインしてください」というメッセージが表示される' do
        visit tasks_path

        expect(page).to have_content('ログインしてください')
      end
    end
  end

  describe 'ログイン機能' do
    context '登録済みのユーザでログインした場合' do

    before do
      visit new_session_path
      fill_in "session_email", with: "mystring@gmail.com"
      fill_in "session_password", with: "MyString"
      click_button "create-session"
    end

      it 'タスク一覧画面に遷移し、「ログインしました」というメッセージが表示される' do
        expect(page).to have_content('ログインしました')
      end

      it '自分の詳細画面にアクセスできる' do
        visit user_path(user)

        click_link "new-task"
        fill_in "task_title", with: "今日の仕事"
        fill_in "task_content", with: "書類作成"
        fill_in "task_deadline_on", with: "002024-02-10"
        select "中", from: "task_priority"
        select "完了", from: "task_status"
        click_button "create-task"
       

        first('.show-task').click

        expect(page).to have_content('タスク詳細ページ')
      end

      it '他人の詳細画面にアクセスすると、タスク一覧画面に遷移する' do
        other_user = User.create(name: 'Alice', email: 'b@gmail.com', password: 'password', password_confirmation: 'password', admin: false)

        visit user_path(other_user)
        expect(page).to have_content('アクセス権限がありません')
      end
      it 'ログアウトするとログイン画面に遷移し、「ログアウトしました」というメッセージが表示される' do
        click_link "sign-out"
        expect(page).to have_content('ログアウトしました')
      end
    end
  end

  describe '管理者機能' do
    context '管理者がログインした場合' do

      before do
        visit new_session_path
        fill_in "session_email", with: "a@gmail.com"
        fill_in "session_password", with: "password"
        click_button "create-session"
      end

      it 'ユーザ一覧画面にアクセスできる' do
        click_link "users-index"
        expect(page).to have_content('ユーザ一覧ページ')
      end

      it '管理者を登録できる' do
        click_link "add-user"
        fill_in "user_name", with: "c"
        fill_in "user_email", with: "c@gmail.com"
        fill_in "user_password", with: "cccccc"
        fill_in "user_password_confirmation", with: "cccccc"
        check "user_admin" 
        click_button "create-user"

        expect(page).to have_content('c@gmail.com')
      end

      it 'ユーザ詳細画面にアクセスできる' do
        click_link "users-index"
        first('.show-user').click
        expect(page).to have_content('ユーザ詳細ページ')
      end
      
      it 'ユーザ編集画面から、自分以外のユーザを編集できる' do

        click_link "users-index"
        first('.edit-user').click
        fill_in "user_name", with: "mystring"
        fill_in "user_email", with: "mystring@gmail.com"
        fill_in "user_password", with: "MyString"
        fill_in "user_password_confirmation", with: "MyString"
        click_button "update-user"

        expect(page).to have_content('mystring')
      end

      it 'ユーザを削除できる' do
        click_link "users-index"
        all('.destroy-user')[0].click
        sleep 2

        page.driver.browser.switch_to.alert.accept

        expect(page).to have_content('ユーザを削除しました')
      end
    end
    context '一般ユーザがユーザ一覧画面にアクセスした場合' do

      before do
        visit new_session_path
        fill_in "session_email", with: "mystring@gmail.com"
        fill_in "session_password", with: "MyString"
        click_button "create-session"
      end

      it 'タスク一覧画面に遷移し、「管理者以外アクセスできません」というエラーメッセージが表示される' do
        visit admin_users_path
        expect(page).to have_content('管理者以外アクセスできません')
      end
    end
  end
end
