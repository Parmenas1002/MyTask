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
                click_on "Show"
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
            expect(task_list.count).to eq 3
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
            click_link "deadline"
            task_list = all('.task_row')
            expect(task_list[0].text).to eq "task1"
            expect(task_list[1].text).to eq "task2"
            expect(task_list[2].text).to eq "task3"
          end
        end
    end

    describe 'Fuzzy Search with only title' do
        context 'If you do a fuzzy search by Title' do
          it 'Filter by tasks that include search keywords' do
            task1 = FactoryBot.create(:task, title: 'task1')           
            task2 = FactoryBot.create(:task, title: 'sample')           
            task3= FactoryBot.create(:task, title: 'sample2')
            visit tasks_path
            fill_in "task[title]", with: "task"
            click_on "Sbtn"
            task_list = all('.task_row')
            expect(task_list.count).to eq 1
            expect(page).to have_content "task1"
          end
        end
    end

    describe 'Search with status only' do
        context 'When you search for status' do
          it 'Tasks that exactly match the status are narrowed down' do
            task1 = FactoryBot.create(:task, title: 'task1', status: 0)           
            task2 = FactoryBot.create(:task, title: 'task2' , status: 2)           
            task3= FactoryBot.create(:task, title:"task3", status:1)
            visit tasks_path
            select "Unstarted", from: "task[status]"
            click_on "Sbtn"
            task_list = all('.task_row')
            expect(task_list.count).to eq 1
            expect(page).to have_content "task1"
          end
        end
    end

    describe 'Search with both title and status' do
        context 'Title performing fuzzy search of title and status search' do
          it 'Tasks that exactly match the status are narrowed down' do
            FactoryBot.create(:task, title: 'task1', status: 0)           
            FactoryBot.create(:task, title: 'sample' , status: 0)           
            FactoryBot.create(:task, title:"task3", status:1)
            visit tasks_path
            fill_in "task[title]", with: "task"
            select "Unstarted", from: "task[status]"
            click_on "Sbtn"
            expect(page).to have_content "task1"
          end
        end
    end

    describe 'Search with model scoope' do
        let!(:task) { FactoryBot.create(:task, title: 'task', status: 0) }
        let!(:second_task) { FactoryBot.create(:second_task, title: "sample",status: 1) }
        context 'Title is performed by scope method' do
            it "Tasks containing search keywords are narrowed down" do            
            expect(Task.search_with_title('task')).to include(task)
            expect(Task.search_with_title('task')).not_to include(second_task)
            expect(Task.search_with_title('task').count).to eq 1
            end
        end

        context 'When the status is searched with the scope method' do
            it "Tasks that exactly match the status are narrowed down" do
                expect(Task.order_by_status(0)).to include(task)
                expect(Task.order_by_status(1)).to include(second_task)
                expect(Task.order_by_status(0).count).to eq 1
            end
        end
        context 'When performing fuzzy search and status search Title' do
            it "Narrow down tasks that include search keywords in the Title and exactly match the status" do
                expect(Task.search_with_title('task').order_by_status(0)).to include(task)
                expect(Task.search_with_title('task').order_by_status(0)).not_to include(second_task)
                expect(Task.search_with_title('task').order_by_status(0).count).to eq 1
            end
        end
    end 

    describe 'Sort Task List by Priority' do
        context 'When tasks are arranged in descending order of priority' do
          it 'Task with high priority is displayed at the top' do
            task1 = FactoryBot.create(:task, title: 'task1', priority: "High")           
            task2 = FactoryBot.create(:task, title: 'task2', priority: "Medium")           
            task3= FactoryBot.create(:task, title: 'task3', priority: "Low")
            visit tasks_path
            click_link "priority"
            task_list = all('.task_row')
            expect(task_list[0].text).to eq "task1"
            expect(task_list[1].text).to eq "task2"
            expect(task_list[2].text).to eq "task3"
          end
        end
    end
    
    
end