class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.where(charge_id: current_user.id)
  end

  def show
    @task = Task.find(params[:id])
  end

  def new
    @task = Task.new(user_id: params[:user_id], charge_id: params[:user_id])
  end

  def edit
    @task = Task.find(params[:id])
    redirect_to(user_tasks_path(current_user)) unless current_user == @user
  end

  def create
    @task = current_user.tasks.build(task_params)
    @task.charge_id = current_user.id

    respond_to do |format|
      if @task.save
        format.html { redirect_to user_tasks_url, notice: 'タスクを登録しました。' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to user_tasks_url, notice: 'タスクを編集しました。' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.html { redirect_to user_tasks_url, notice: 'タスクを削除しました' }
    end
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:user_id, :title, :content, :deadline, :charge_id, :done, :status)
    end

    def correct_user
      @user = User.find(params[:user_id])
    end
end
