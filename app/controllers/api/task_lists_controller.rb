class Api::TaskListsController < ApplicationController
  before_action :check_owner, only: [:update, :destroy]

  def create
    task_list = current_user.task_lists.create(task_list_params)
    if task_list.valid?
      render json: {success: true, model: task_list}
    else
      render json: {success: false, errors: task_list.errors}
    end
  end


  def destroy
    success =  task_list.destroy()
    render json: {success: !success.blank?}, status: 200
  end

  def update
    success =  task_list.update_attributes(task_list_params)
    render json: {success: success, model: task_list}, status: 200
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
