class Api::TasksController < ApplicationController
  before_action :check_owner, only: [:create, :update, :destroy]

  def create
    task = task_list.tasks.create(task_params)
    if task.valid?
      render json: {success: true, model: task}
    else
      render json: {success: false, errors: task.errors}
    end
  end


  def destroy
    success =  task.destroy()
    render json: {success: !success.blank?}, status: 200
  end

  def update
    success =  task.update_attributes(task_params)
    render json: {success: success, model: task}, status: 200
  end

  private

  def check_owner
    current_user && (task_list.user_id == current_user.id)
  end

  def task
    @task ||= Task.find(params[:id]) if params[:id]
  end

  def task_list
    @task_list ||= task ? task.task_list : TaskList.find(params[:model][:task_list_id])
  end

  def task_params
    params.require(:model).permit(:description, :priority, :due_date)
  end

end
