require 'rails_helper'
RSpec.describe 'Task Test Management Function', type: :system do
    before do
    # Create task with factory
        FactoryBot.create(:task)
        FactoryBot.create(:second_task)
       
    end
    describe 'Task Creation' do
        context 'When we are creating a task' do
            it 'Created task is created' do
                visit new_task_path
                fill_in "task[title]",	with: "Task 1" 
                fill_in "task[description]",	with: "Task 1 Description"
                click_on "Add Task"
                expect(page).to have_content "Task 1"
            end
        end
    end
    describe 'List of Task' do
        context 'When we are going to task list' do
        it 'All tasks is listed on the page' do
            task = FactoryBot.create(:task, title: 'task')
            visit tasks_path
            expect(page).to have_content 'task'
        end
        end
    end
    describe 'Task Details Page' do
        context 'When we are going to task details page ' do
        it 'The specified task is realy present' do
        end
        end
    end
end