class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :name, :priority,  :number_of_completed_tasks, :number_of_tasks, :status

  has_many :tasks

end