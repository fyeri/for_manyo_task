require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '登録機能' do
    context 'タスクを登録した場合' do
      it '登録したタスクが表示される' do
        
        # Task.create!(title: '書類作成', content: '企画書を作成する。')
        FactoryBot.create(:task)
        visit tasks_path
        
        expect(page).to have_content ''
        expect(page).to have_content '企画書を作成する。'

      end
    end
  end

  describe '一覧表示機能' do
       # let!を使ってテストデータを変数として定義することで、複数のテストでテストデータを共有できる

       let!(:first_task) { FactoryBot.create(:task, title: 'first_task', created_at: '2022-02-18') }
       let!(:second_task) { FactoryBot.create(:task, title: 'second_task', created_at: '2022-02-17') }
       let!(:third_task) { FactoryBot.create(:task, title: 'third_task', created_at: '2022-02-16') }
 # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
       before do
          visit tasks_path
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

        new_task = FactoryBot.create(:task, title: 'new_task', created_at: '2022-02-20')

        click_link "new-task"

        fill_in "task_title", with: "今日の仕事"
        fill_in "task_content", with: "書類作成"

        click_button "create-task"

        expected_content = [
          /.*new_task.*2022-02-20.*/,
          /.*first_task.*2022-02-18.*/,
          /.*second_task.*2022-02-17.*/,
          /.*third_task.*2022-02-16.*/
        ]
        
        task_list = all('body table tbody tr').map { |row| row.all('td').map(&:text).join(' ') }

        expect(task_list[1]).to have_content(expected_content[0])
        expect(task_list[2]).to have_content(expected_content[1])
        expect(task_list[3]).to have_content(expected_content[2])
        expect(task_list[4]).to have_content(expected_content[3])    
      end
    end    
  end


  describe '詳細表示機能' do
     context '任意のタスク詳細画面に遷移した場合' do
       it 'そのタスクの内容が表示される' do
        # task = Task.create!(title: '書類作成', content: '企画書を作成する。')

        task = FactoryBot.create(:task)
       
        visit task_path(task)

        expect(page).to have_content '書類作成'
        expect(page).to have_content '企画書を作成する。'
       end
     end
  end
end