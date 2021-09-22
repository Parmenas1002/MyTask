FactoryBot.define do
    factory :task do
      title { 'Title 1 created by factory 1 ' }
      description { 'Description created by factory one' }
    end

    factory :second_task, class: Task do
        title { 'Title 2 created by factory 2 ' }
        description { 'Description created by factory two' }
      end
  end