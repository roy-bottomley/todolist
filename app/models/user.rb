class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :task_lists, inverse_of: :user, dependent: :destroy

  def create_task_list
  end

  def delete_task_list
  end

end
