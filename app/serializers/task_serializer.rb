class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :priority,  :due_date, :completed, :due_date_formatted, :valid, :errors

  def due_date_formatted
    object.due_date.strftime('%a  %d %b %Y') if object.due_date
  end

  def valid
    object.valid?
  end
  def errors
   object.errors.full_messages.to_sentence
  end
end