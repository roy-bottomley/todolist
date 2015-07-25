class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  has_many :task_lists

  def email
    object.email
  end
end
