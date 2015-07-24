class Task < ActiveRecord::Base
  belongs_to :task_list, inverse_of: :tasks

  validates_length_of :description, :minimum => 5
  validates_uniqueness_of :description, :scope => [:task_list_id, :due_date]
  validate :due_date_must_be_in_the_future

  private

  def due_date_must_be_in_the_future
    errors.add(:due_date, "must be in the future") if
        !due_date.blank? and due_date < Date.today
  end

end
