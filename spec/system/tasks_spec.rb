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
      let!(:task) { FactoryBot.create(:task, title: 'task_title') }
 # 「一覧画面に遷移した場合」や「タスクが作成日時の降順に並んでいる場合」など、contextが実行されるタイミングで、before内のコードが実行される
       before do
          visit tasks_path
       end

    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が作成日時の降順で表示される' do

        task_list = all('body tr')
        
        expect(page).to 
        expect(page).to have_content '書類作成'
        # expectの結果が「真」であれば成功、「偽」であれば失敗としてテスト結果が出力される
      end
    end
     context '新たにタスクを作成した場合' do
       it '新しいタスクが一番上に表示される' do


        expect(page).to task_title = first_task
        expect(page).to task_title = second_task
        expect(page).to task_title = third_task
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