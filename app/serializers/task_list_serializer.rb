class TaskListSerializer < ActiveModel::Serializer
  attributes :id, :name, :priority,  :number_of_completed_tasks, :number_of_tasks, :status, :valid, :errors

  def valid
    object.valid?
  end

  def errors
    object.errors.full_messages.to_sentence
  end

end