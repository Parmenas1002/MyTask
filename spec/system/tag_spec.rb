require 'rails_helper'
def login
    visit new_session_path
    fill_in "session[email]",	with: "from@example.com"
    fill_in "session[password]",	with: "password"
    click_on "Login"
end

RSpec.describe 'Tag test System', type: :system do
    before do     
    end
    describe 'Task Creation with tag' do
        let!(:user) { FactoryBot.create(:user) }
        FactoryBot.create(:tag, name: 'Sport')
        FactoryBot.create(:tag, name: 'Cinema')
        context 'When we are creating a task' do
            it 'Created task is created with a tag' do
                login()
                visit new_task_path
                fill_in "task[title]",	with: "Task 1" 
                fill_in "task[description]",	with: "Task 1 Description"
                check 'task_tag_ids_1'
                click_on "Add Task"
                expect(page).to have_content "Sport"
            end
        end
    end
    describe 'Task Creation with tag' do
        let!(:user) { FactoryBot.create(:user) }
        FactoryBot.create(:tag, name: 'Watch')
        context 'When we are search by tag a task' do
            it 'I get Task with selected tag' do
                login()
                visit new_task_path
                fill_in "task[title]",	with: "Task1" 
                fill_in "task[description]",	with: "Task 1 Description"
                check 'task_tag_ids_'+ Tag.count.to_s
                click_on "Add Task"
                visit tasks_path
                select "Watch", from: "task[tag_id]"
                click_on "Sbtn"
                task_list = all('.task_row')
                expect(task_list.count).to eq 1
                expect(page).to have_content "Task1"
            end
        end
    end
end