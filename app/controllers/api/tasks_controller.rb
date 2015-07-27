class Api::TasksController < ApplicationController
  before_action :check_owner, only: [:create, :update, :destroy]

  def index
    render json: task_list.tasks
  end

  def create
    task = task_list.tasks.create(task_params)
    render json: task
  end


  def destroy
    success =  task.destroy()
    render json: {success: !success.blank?}, status: 200
  end

  def update
    success = task.update_attributes(task_params)
    render json: task, status: 200
  end

  private

  def check_owner
    current_user && (task_list.user_id == current_user.id)
  end

  def task
    @task ||= Task.find(params[:id]) if params[:id]
  end

  def task_list
    @task_list ||= task ? task.task_list : TaskList.find(params[:parent_id] || params[:model][:task_list_id])
  end

  def task_params
    params.require(:model).permit(:description, :priority, :due_date, :completed)
  end

end
