class TasksController < ApplicationController
  before_action :set_params, only:[:show,:edit,:update,:destroy]


  def index
    @tasks = Task.all.order('created_at DESC')
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] = t("view.success")
      redirect_to tasks_path
    else
      flash[:danger] = t("view.failed")
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] = t("view.success")
      redirect_to tasks_path
    else
      flash[:danger] = t("view.failed")
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:danger] = t("view.deleted")
    redirect_to tasks_path
  end

  private

  def set_params
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title,:content)
  end
end
