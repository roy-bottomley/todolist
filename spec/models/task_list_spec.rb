# == Schema Information
#
# Table name: task_lists
#
#  id         :integer          not null, primary key
#  name       :string(255)      default(""), not null
#  priority   :integer          default(0), not null
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

RSpec.describe TaskList, :type => :model do

  describe "Properties" do
    before(:all) { @task_list = TaskList.new}

    describe "attributes" do
      [:user, :tasks, :priority].each do |attribute|
        it("should respond to #{attribute}") {
          expect(@task_list).to respond_to attribute
        }
      end
    end

    describe "methods" do
      [:number_of_completed_tasks, :number_of_tasks, :status].each do |method|
        it("should respond to #{method}") {
          expect(@task_list).to respond_to method
        }
      end
    end
  end

  describe "Validations" do
    it("should be valid with an name and priority") {
      tasklist = TaskList.new(name: "some task #{TaskList.count}")  # priority should default to zero
      expect(tasklist).to be_valid
    }

    it("should not be valid with an name less than 1 character") {
      tasklist = TaskList.new(name: '')
      expect(tasklist).to_not be_valid
    }

    it("should not be valid with a blank priority") {
      tasklist = TaskList.new(name: 'some task #{TaskList.count}', priority: nil)
      expect(tasklist).to_not be_valid
    }

    it("should not be valid with a non numerical priority ") {
      tasklist = TaskList.new(name: 'some task #{TaskList.count}', priority: 'string')
      expect(tasklist).to_not be_valid
    }

    it("should not be valid with a duplicate name and the same user_id ") {
      tasklist1 = TaskList.create(name: 'duplicate test1', user_id: 1)
      expect(tasklist1.id).to_not be nil

      tasklist2 = TaskList.new(name: 'duplicate test1', user_id: 1)
      expect(tasklist2).to_not be_valid
    }

    it("should be valid with a duplicate name and the a different user_id ") {
      tasklist1 = TaskList.create(name: 'duplicate test2', user_id: 1)
      expect(tasklist1.id).to_not be nil

      tasklist2 = TaskList.new(name: 'duplicate test2', user_id: 2)
      expect(tasklist2).to be_valid
    }

  end

  describe "Task Information" do
    before(:all) {
      @tasklist = TaskList.create(name: 'Task Info test')

      @num_tasks = 5
      @num_completed = 2
      @status = '40%' # 2 of 5 completed

      @num_tasks.times{ |i| @tasklist.tasks.create(description: "task#{i}", due_date: Date.today)}
      @num_completed.times{ |i| @tasklist.tasks[i].update_attributes( completed: true)}

    }

    it("should count the number of tasks") {
      expect(@tasklist.number_of_tasks).to eq  @num_tasks
    }

    it("should count the number of completed tasks") {
      expect(@tasklist.number_of_completed_tasks).to eq  @num_completed
    }

    it("should calculate the status") {
      expect(@tasklist.status).to eq  @status
    }

    it("should retrun nil for the satus if there are no tasks") {
      tasklist = TaskList.create(name: 'nil test')
      expect(tasklist.status).to be nil
    }

  end

  describe "setting priority" do
    before(:all) {
      user =  FactoryGirl.create(:user)
      @tasklist0 = user.task_lists.create(name: 'priority0')
      @tasklist1 = user.task_lists.create(name: 'priority1')
      @tasklist2 = user.task_lists.create(name: 'priority2')
    }

    it("should have a higher priority for the last task added ") {
      expect(@tasklist1.priority).to be >  @tasklist0.priority
      expect(@tasklist2.priority).to be >  @tasklist1.priority
    }

  end

end
