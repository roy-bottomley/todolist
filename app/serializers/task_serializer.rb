class TaskSerializer < ActiveModel::Serializer
  attributes :id, :description, :priority,  :due_date, :due_date_formatted

  def due_date_formatted
    object.due_date.strftime('%a  %d %b %Y') if object.due_date
  end
end