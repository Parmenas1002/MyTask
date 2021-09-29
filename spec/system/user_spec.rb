require 'rails_helper'
def login
    visit new_session_path
    fill_in "session[email]",	with: "from@example.com"
    fill_in "session[password]",	with: "password"
    click_on "Login"
end
def login_admin
    visit new_session_path
    fill_in "session[email]",	with: "admin@example.com"
    fill_in "session[password]",	with: "password"
    click_on "Login"
end

RSpec.describe 'User Test Management Function', type: :system do
    before do   
        
    end
    describe 'Test for user registration ' do 
        context 'When we are creating a new user' do
            it "User is created" do     
                visit new_user_path
                fill_in "user[email]",	with: "example@gmail.com" 
                fill_in "user[name]",	with: "User"
                fill_in "user[password]",	with: "password"
                fill_in "user[password_confirmation]",	with: "password"
                click_on "Create Account"
                expect(page).to have_content "User"      
            end
        end

        context 'When the user tries to jump to the task list screen without logging in, transition to the login screen' do
            it "Redirect to session new page " do
                visit tasks_path
                expect(page).to have_button "Login"
            end
        end
    end 

    describe 'Testing user session functionnality' do 
        let!(:user) { FactoryBot.create(:user) }
        let!(:admin) { FactoryBot.create(:admin) }
        context 'When the user tries to log in ' do
            it "Redirect to tasks list page" do
                login()
                expect(page).to have_content "Your Task List"       
            end
        end
        context 'When the user tries to see My page' do
            it "You can jump to your details screen " do
                login()
                click_on "Profile"       
                expect(page).to have_content "Name"    
                expect(page).to have_content "from@example.com"  
            end
        end
        context "When a general user jumps to another person's details screen, it will transition to the task list screen" do
            it "You are redirect to task_list" do
                login()
                visit user_path(admin.id)    
                expect(page).to have_content "Your Task List"  
            end
        end
        context "When the user to logout" do
            it "You are redirect to login page" do
                login()
                click_on "Logout"   
                expect(page).to have_button "Login"  
            end
        end
    end 

    describe 'Testing Admin screen' do 
        let!(:user) { FactoryBot.create(:user) }
        let!(:admin) { FactoryBot.create(:admin) }
        context 'When admin try to access admin page ' do
            it "Redirect to users list page" do
                login_admin()
                visit admin_users_path
                expect(page).to have_content "Admin Interface"      
            end
        end
        context 'When the general user tries to access admin page' do
            it "The user is redirect to tasks list with error" do
                login()
                visit admin_users_path         
                expect(page).to have_content "Your Task List" 
            end
        end
        context "When admin want to add a new user" do
            it "New user is created" do
                login_admin()
                visit new_admin_user_path   
                expect(page).to have_button "Create Account"  
                fill_in "user[email]",	with: "example@gmail.com" 
                fill_in "user[name]",	with: "User"
                select "General User", from: "user[admin]"
                fill_in "user[password]",	with: "password"
                fill_in "user[password_confirmation]",	with: "password"
                click_on "Create Account"
                expect(page).to have_content "User"
                expect(page).to have_content "example@gmail.com"
            end
        end
        context "When the admin tries to visit an user page" do
            it "Admin can access to user details page" do
                login_admin()
                visit admin_user_path(user.id)
                expect(page).to have_content "Name"    
                expect(page).to have_content "from@example.com"     
            end
        end

        context "When the admin tries to edit an user information" do
            it "User informations is updated" do
                login_admin()
                visit admin_users_path 
                expect(page).to have_content "Name" 
                expect(page).to have_content "from@example.com"  
                visit edit_admin_user_path(user.id)
                fill_in "user[name]",	with: "My name"
                fill_in "user[email]",	with: "newemail@gmail.com" 
                click_on "Save" 
                expect(page).to have_content "My name"    
                expect(page).to have_content "newemail@gmail.com"   
            end
        end

        context "When the admin tries to delete an user" do
            it "User is deleted with success" do
                login_admin()
                visit admin_users_path 
                expect(page).to have_content "Name" 
                expect(page).to have_content "from@example.com"  
                delete_buttons = all('.delete-link')
                expect(delete_buttons.count).to eq 6
                page.accept_confirm do
                    delete_buttons[5].click
                end
                expect(page).to have_content "User delete with success"      
            end
        end
    end 

    


    
end