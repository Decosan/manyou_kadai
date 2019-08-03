# このrequireで、Capybaraなどの、Feature Specに必要な機能を使用可能な状態にしています
require 'rails_helper'

# このRSpec.featureの右側に、「タスク管理機能」のように、テスト項目の名称を書きます（do ~ endでグループ化されています）
RSpec.feature "タスク管理機能", type: :feature do
  background do
    # あらかじめタスク一覧のテストで使用するためのタスクを二つ作成する

    # backgroundの中に記載された記述は、そのカテゴリ内（feature "タスク管理機能", type: :feature do から endまでの内部）
    # に存在する全ての処理内（scenario内）で実行される
    # （「タスク一覧のテスト」でも「タスクが作成日時の降順に並んでいるかのテスト」でも、background内のコードが実行される）
    FactoryBot.create(:task)
    FactoryBot.create(:second_task)
    FactoryBot.create(:third_task)
    FactoryBot.create(:fourth_task)
    FactoryBot.create(:fifth_task)
  end
  scenario "タスク一覧のテスト" do
    
    visit tasks_path

    # visitした（到着した）expect(page)に（タスク一覧ページに）「testtesttest」「samplesample」という文字列が
    # have_contentされているか？（含まれているか？）ということをexpectする（確認・期待する）テストを書いている
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント1'
    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント2'
  end

  scenario "タスク作成のテスト" do
    visit new_task_path
    
    fill_in "タスク名", with: "Today.."
    fill_in "タスク内容", with: "So what.."

    click_on '登録'
    
    # save_and_open_page

    expect(page).to have_content 'So what..'
  end

  
  scenario "タスク詳細のテスト" do
    
    visit tasks_path
    # save_and_open_page
    all('li')[0].click_on '詳細へ'

    expect(page).to have_content 'Factoryで作ったデフォルトのコンテント5'
  end

  scenario "タスクが作成日時の降順に並んでいるかのテスト" do
    # ここにテスト内容を記載する
    visit tasks_path
    save_and_open_page
    
    task_0 = all('li')[0]
    task_2 = all('li')[2]
    task_4 = all('li')[4]
    expect(task_0).to have_content "Factoryで作ったデフォルトのコンテント5"
    expect(task_2).to have_content "Factoryで作ったデフォルトのコンテント3"
    expect(task_4).to have_content "Factoryで作ったデフォルトのコンテント1"
    
  end
end