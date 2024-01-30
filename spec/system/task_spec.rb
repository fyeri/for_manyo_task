require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  describe '登録機能' do
    before do
      visit new_session_path
      fill_in "session_email", with: "mystring@gmail.com"
      fill_in "session_password", with: "MyString"
      click_button "create-session"
    end
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        click_link "new-task"

        fill_in "task_title", with: "今日の仕事"
        fill_in "task_content", with: "書類作成"
        fill_in "task_deadline_on", with: "002024-02-10"
        select "中", from: "task_priority"
        select "完了", from: "task_status"
        click_button "create-task"
        
        expect(page).to have_content '今日の仕事'
      end
    end
  end

  describe '一覧表示機能' do
       # let!を使ってテストデータを変数として定義することで、複数のテストでテストデータを共有できる
       let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中", status: "未着手", user: user ) }
       let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17', deadline_on: '2025-02-17', priority: "高", status: "着手中",user: user  ) }
       let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16', deadline_on: '2025-02-17', priority: "低", status: "完了",user: user ) }
   
 # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
       before do
          visit new_session_path
          fill_in "session_email", with: "mystring@gmail.com"
          fill_in "session_password", with: "MyString"
          click_button "create-session"
       end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do
    
        expected_content = [
          /.*first_task.*2022-02-18.*/,
          /.*second_task.*2022-02-17.*/,
          /.*third_task.*2022-02-16.*/
        ]
 
        task_list = all('body tr')
        expect(task_list[1]).to have_content(expected_content[0])
        expect(task_list[2]).to have_content(expected_content[1])
        expect(task_list[3]).to have_content(expected_content[2])
      end
    end

     context '新たにタスクを作成した場合' do
       it '新しいタスクが一番上に表示される' do
        click_link "new-task"
   
        fill_in "task_title", with: "今日の仕事"
        fill_in "task_content", with: "書類作成"
        fill_in "task_deadline_on", with: "002024-02-10"
        select "中", from: "task_priority"
        select "完了", from: "task_status"

        click_button "create-task"

        expected_content = [
          /.*今日の仕事.*2024-02-10.*/,
          /.*first_task.*2022-02-18.*/,
          /.*second_task.*2022-02-17.*/,
          /.*third_task.*2022-02-16.*/
        ]
        
        task_list = all('body table tbody tr').map { |row| row.all('td').map(&:text).join(' ') }

        expect(task_list[0]).to have_content(expected_content[0])
        expect(task_list[1]).to have_content(expected_content[1])
        expect(task_list[2]).to have_content(expected_content[2]) 
        expect(task_list[3]).to have_content(expected_content[3]) 
        expect(task_list[4]).to have_content(expected_content[4]) 
      end
    end 
    
    describe 'ソート機能' do
      let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中", status: "未着手", user: user ) }
      let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17', deadline_on: '2025-02-17', priority: "高", status: "着手中",user: user  ) }
      let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16', deadline_on: '2025-02-16', priority: "低", status: "完了",user: user ) }

     

      context '「終了期限」というリンクをクリックした場合' do
        it "終了期限昇順に並び替えられたタスク一覧が表示される" do
          # allメソッドを使って複数のテストデータの並び順を確認する
    
          click_on '終了期限'
          sleep 1


          expected_sorted_content = [
            /.*third_task.*2025-02-16.*/,
            /.*second_task.*2025-02-17.*/,
            /.*first_task.*2025-02-18.*/,
          ]
    
          sorted_task_list = all('body table tbody tr').map { |row| row.all('td').map(&:text).join(' ') }

          expect(sorted_task_list[0]).to have_content(expected_sorted_content[0])
          expect(sorted_task_list[1]).to have_content(expected_sorted_content[1])
          expect(sorted_task_list[2]).to have_content(expected_sorted_content[2])
        end
      end


      context '「優先度」というリンクをクリックした場合' do
        it "優先度の高い順に並び替えられたタスク一覧が表示される" do
          # allメソッドを使って複数のテストデータの並び順を確認する
          click_on '優先度'
          sleep 1

          expected_order = [
            /.*second_task.*高.*/,
            /.*first_task.*中.*/,
            /.*third_task.*低.*/
          ]
    
          priority_task_list = all('body table tbody tr').map { |row| row.all('td').map(&:text).join(' ') }
    
          expect(priority_task_list[0]).to have_content(expected_order[0])
          expect(priority_task_list[1]).to have_content(expected_order[1])
          expect(priority_task_list[2]).to have_content(expected_order[2])
        end
      end
    end
  end
    describe '検索機能' do
      let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中", status: "未着手",user: user) }
      let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17', deadline_on: '2025-02-17', priority: "高", status: "着手中",user: user) }
      let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16', deadline_on: '2025-02-16', priority: "低", status: "完了",user: user) }

      before do
        visit new_session_path
        fill_in "session_email", with: "mystring@gmail.com"
        fill_in "session_password", with: "MyString"
        click_button "create-session"
     end

      context 'タイトルであいまい検索をした場合' do
        it "検索ワードを含むタスクのみ表示される" do
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
          fill_in "search_title", with: 'first'
          
          click_button '検索'
       
         expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end
      context 'ステータスで検索した場合' do
        it "検索したステータスに一致するタスクのみ表示される" do
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する

          select "完了", from: "search_status"
          click_button '検索'

          expect(page).to have_content 'third_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'first_task'
        end
      end

      context 'タイトルとステータスで検索した場合' do
        it "検索ワードをタイトルに含み、かつステータスに一致するタスクのみ表示される" do
          # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する

          fill_in "search_title", with: 'first'
          select "未着手", from: "search_status"
          click_button '検索'

          expect(page).to have_content 'first_task'
          expect(page).not_to have_content 'second_task'
          expect(page).not_to have_content 'third_task'
        end
      end
    end
  end


  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
      let!(:user) { FactoryBot.create(:user) }

      let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中", status: "未着手",user: user) }
      let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17', deadline_on: '2025-02-17', priority: "高", status: "着手中",user: user) }
      let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16', deadline_on: '2025-02-16', priority: "低", status: "完了",user: user) }

      before do
        visit new_session_path
        fill_in "session_email", with: "mystring@gmail.com"
        fill_in "session_password", with: "MyString"
        click_button "create-session"
     end
     it 'そのタスクの内容が表示される' do

      
      first('.show-task').click

        expect(page).to have_content 'first_task'
        expect(page).to have_content '企画書を作成する。'
        expect(page).not_to have_content 'second_task'
        expect(page).not_to have_content 'third_task' 
    end
  end
  describe '検索機能' do
    context 'ラベルで検索をした場合' do 
     let!(:user) { FactoryBot.create(:user) }
      let!(:label) { FactoryBot.create(:label,user:user)}

      let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18', deadline_on: '2025-02-18', priority: "中",labels: [label], status: "未着手",user: user) }

      let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17', deadline_on: '2025-02-17', priority: "高", status: "着手中" ,user: user) }
      let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16', deadline_on: '2025-02-16', priority: "低", status: "完了", user: user) }

      before do
      visit new_session_path
      fill_in "session_email", with: "mystring@gmail.com"
      fill_in "session_password", with: "MyString"
      click_button "create-session"
     end
     
     it "そのラベルの付いたタスクがすべて表示される" do
      select "ラベル1", from: "search_label"
      click_button '検索'

      expect(page).to have_content 'first_task'
      expect(page).not_to have_content 'second_task'
      expect(page).not_to have_content 'third_task' 

        # toとnot_toのマッチャを使って表示されるものとされないものの両方を確認する
      end
    end
  end
end
