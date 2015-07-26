# == Schema Information
#
# Table name: tasks
#
#  id           :integer          not null, primary key
#  description  :string(255)      default(""), not null
#  priority     :integer          default(0), not null
#  due_date     :date
#  completed    :boolean          default(FALSE), not null
#  status       :integer          default(0), not null
#  task_list_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

RSpec.describe Task, :type => :model do
  describe "Properties" do
    before(:all) { @task = Task.new}

    describe "attributes" do
      [:task_list, :description, :priority, :status, :completed].each do |attribute|
        it("should respond to #{attribute}") {
          expect(@task).to respond_to attribute
        }
      end
    end
  end

  describe "Validations" do
    it("should be valid with an description and due date") {
      task = Task.new(description: 'some description', due_date: Date.today)
      expect(task).to be_valid
    }

    it("should not be valid if completed is nil") {
      task = Task.new(description: 'four', due_date: Date.today, completed: nil)
      expect(task).to_not be_valid
    }

    it("should not be valid if status is nil") {
      task = Task.new(description: 'four', due_date: Date.today, status: nil)
      expect(task).to_not be_valid
    }

    it("should not be valid with an description less than 4 character4") {
      task = Task.new(description: 'four', due_date: Date.today)
      expect(task).to_not be_valid
    }

    it("should not be valid with a duplicate name and the same task_list_id and due date") {
     task1 = Task.create(description: 'some description1', due_date: Date.today, task_list_id: 1)
      expect(task1.id).to_not be nil

     task2 = Task.create(description: 'some description1', due_date: Date.today, task_list_id: 1)
      expect(task2).to_not be_valid
    }

    it("should be valid with a duplicate name and the a different task_list_id ") {
     task1 = Task.create(description: 'some description2', due_date: Date.today, task_list_id: 1)
      expect(task1.id).to_not be nil

     task2 = Task.create(description: 'some description2', due_date: Date.today, task_list_id: 2)
      expect(task2).to be_valid
    }

    it("should be valid with a duplicate name and the a different due date ") {
     task1 = Task.create(description: 'some description3', due_date: Date.today, task_list_id: 1)
      expect(task1.id).to_not be nil

     task2 = Task.create(description: 'some description3', due_date: (Date.today + 1.day), task_list_id: 1)
      expect(task2).to be_valid
    }
  end

  describe "setting priority" do
    before(:all) {
      tasklist = TaskList.create(name: "some task #{TaskList.count}")
      @task0 = tasklist.tasks.create(description: 'priority0', due_date: Date.today, task_list_id: 1)
      @task1 = tasklist.tasks.create(description: 'priority1', due_date: Date.today, task_list_id: 1)
      @task2 = tasklist.tasks.create(description: 'priority2', due_date: Date.today, task_list_id: 1)
    }

    it("should have a higher priority for the last task added ") {
      expect(@task1.priority).to be >  @task0.priority
      expect(@task2.priority).to be >  @task1.priority
    }

  end
end
