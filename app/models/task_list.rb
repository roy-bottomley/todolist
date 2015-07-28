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

class TaskList < ActiveRecord::Base
  belongs_to  :user, inverse_of: :task_lists
  has_many :tasks, inverse_of: :task_list, dependent: :destroy

  validates_length_of :name, :minimum => 1
  validates :priority, :numericality => true
  validates :name, uniqueness: { scope: [:user_id] }

  before_create :set_priority

  def number_of_completed_tasks
    tasks.where(completed: true).size
  end

  def number_of_tasks
    tasks.size
  end

  def status
    "#{(100 * number_of_completed_tasks / number_of_tasks).floor}%" if number_of_tasks > 0
  end

  before_create :set_priority

  private

  def set_priority
    self.priority =  user.task_lists.maximum('priority') + 1 if user && user.task_lists.size > 0
  end


end
