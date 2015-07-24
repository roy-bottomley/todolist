class TaskList < ActiveRecord::Base
  belongs_to  :user, inverse_of: :task_lists
  has_many :tasks, inverse_of: :task_list, dependent: :destroy

  validates_length_of :name, :minimum => 1
  validates :priority, :numericality => true
  validates :name, uniqueness: { scope: [:user_id] }

  def number_of_completed_tasks
    tasks.where(completed: true).size
  end

  def number_of_tasks
    tasks.size
  end

  def status
    "#{(100 * number_of_completed_tasks / number_of_tasks).floor}%"
  end

end
