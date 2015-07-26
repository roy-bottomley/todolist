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

class Task < ActiveRecord::Base
  belongs_to :task_list, inverse_of: :tasks

  validates_length_of :description, :minimum => 5
  validates_uniqueness_of :description, :scope => [:task_list_id, :due_date]
  validate :due_date_must_be_in_the_future

  before_create :set_priority
  before_create :set_due_date

  private

  def set_priority
     self.priority =  task_list.tasks.maximum('priority') + 1 if task_list && task_list.tasks.size > 0
  end

  def set_due_date
    self.due_date =  Date.today + 1.year if self.due_date.blank?
  end

  def due_date_must_be_in_the_future
    errors.add(:due_date, "must be in the future") if
        !due_date.blank? and due_date < Date.today
  end

end
