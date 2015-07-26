class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :name, :priority,  :number_of_completed_tasks, :number_of_tasks, :status
end