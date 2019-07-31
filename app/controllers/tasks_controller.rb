class TasksController < ApplicationController
  before_action :set_params, only:[:show,:edit,:update,:destroy]


  def index
    @tasks = Task.all
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    if @task.save
      flash[:success] ='Task created'
      redirect_to tasks_path
    else
      flash[:danger] ="Failed.."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      flash[:success] ="Task updated"
      redirect_to tasks_path
    else
      flash[:danger] ="Failed.."
      render 'edit'
    end
  end

  def destroy
    @task.destroy
    flash[:danger] ="Task deleted"
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
