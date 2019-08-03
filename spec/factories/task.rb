# 「FactoryBotを使用します」という記述
FactoryBot.define do

  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    created_at {1}
  end

  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    created_at {2}
  end

  factory :third_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル3' }
    content { 'Factoryで作ったデフォルトのコンテント3' }
    created_at {3}
  end

  factory :fourth_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル4' }
    content { 'Factoryで作ったデフォルトのコンテント4' }
    created_at {4}
  end

  factory :fifth_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル5' }
    content { 'Factoryで作ったデフォルトのコンテント5' }
    created_at {5}
  end
end