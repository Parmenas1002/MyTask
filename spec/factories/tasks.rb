FactoryBot.define do
    factory :task do
      title { 'task' }
      description { 'Description created by factory one' }
    end

    factory :second_task, class: Task do
        title { 'Title 2 created by factory 2 ' }
        description { 'Description created by factory two' }
    end
  end