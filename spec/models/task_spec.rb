require 'rails_helper'

RSpec.describe Task, type: :model do
  
    it "It's hard to Validation" do
      task = Task.new(title: '', description: 'Failure test')
      expect(task).not_to be_valid
    end
    
    it 'Validation is caught' do
      task = Task.new(title: "Title", description: "")
      expect(task).to be_valid
    end
    
    it 'Validation passes' do
      task = Task.new(title: "Title", description: "My description")
      expect(task).to be_valid
    end
    
end
