class Api::TaskListsController < ApplicationController
  before_action :check_owner, only: [:update, :destroy]

  def index
    render json: current_user.task_lists
  end

  def create
    task_list = current_user.task_lists.create(task_list_params)
    render json:  task_list
  end


  def destroy
    success =  task_list.destroy()
    render json: {success: !success.blank?}, status: 200
  end

  def update
    task_list.update_attributes(task_list_params)
    render json:  task_list, status: 200
  end

  private

  def check_owner
    current_user && (task_list.user_id == current_user.id)
  end

  def task_list
    @task_list ||= TaskList.find(params[:id])
  end

  def task_list_params
    params.require(:model).permit(:name, :priority)
  end

end
