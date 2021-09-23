require 'rails_helper'
RSpec.describe 'Task Test Management Function', type: :system do
    before do
    # Create task with factory
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
                task = FactoryBot.create(:task, title: 'task')
                visit tasks_path
                click_on "Details"
                expect(page).to have_content "task"
            end
        end
    end
    describe 'Ordering Task List' do
        context 'When tasks are arranged in descending order of creation date and time' do
          it 'New task is displayed at the top' do
            FactoryBot.create(:task, title: 'task1')
            FactoryBot.create(:task, title: 'task2')
            FactoryBot.create(:task, title: 'task3')
            visit tasks_path
            task_list = all('.task_row')
            expect(task_list[0].text).to eq "task3"
          end
        end
    end

    describe 'Sort Task List by deadline' do
        context 'When tasks are arranged in descending order of deadline date and time' do
          it 'Task with high dealine is displayed at the top' do
            task1 = FactoryBot.create(:task, title: 'task1', expiredDate: DateTime.parse("2021-09-23 12:30:14"))           
            task2 = FactoryBot.create(:task, title: 'task2', expiredDate: DateTime.parse("2021-09-23 11:30:14"))           
            task3= FactoryBot.create(:task, title: 'task3', expiredDate: DateTime.parse("2021-09-23 10:30:14"))
            visit tasks_path
            click_on "Sort by end deadline"
            task_list = all('.task_row')
            expect(task_list[0].text).to eq "task1"
          end
        end
    end
    
end