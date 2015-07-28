class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  def email
    object.email
  end

end
