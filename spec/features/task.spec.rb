# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
    # scenario（itのalias）の中に、確認したい各項目のテストの処理を書きます。
  scenario "タスク一覧のテスト" do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する
    Task.create!(title: 'test_task_01', content: 'testtesttest')
    Task.create!(title: 'test_task_02', content: 'samplesample')

    # tasks_pathにvisitする（タスク一覧ページに遷移する）
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'testtesttest'
    expect(page).to have_content 'samplesample'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    
    fill_in "Title", with: "Today.."
    fill_in "Content", with: "So what.."

    click_on 'Create'
    
    # save_and_open_page

    expect(page).to have_content 'So what..'
  end

  
  scenario "タスク詳細のテスト" do
    Task.create!(title: 'test_task_03', content: 'testtesttest2')

    visit tasks_path
    # save_and_open_page
    click_on 'Detail'

    expect(page).to have_content 'testtesttest2'
  end
end