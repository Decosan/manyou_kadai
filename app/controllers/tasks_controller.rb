class TasksController < ApplicationController
  before_action :set_params, only:[:show,:edit,:update,:destroy]
  before_action :require_user_logged_in

  def index
    if params[:task] && params[:task][:search]
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = Task.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = Task.title_search(params[:task][:title]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = Task.status_search(params[:task][:status]).page(params[:page])
      end
    elsif params[:sort_expired]
      @tasks = Task.nil_limit.limit_sort.page(params[:page])
    elsif params[:sort_priority]
      @tasks = Task.order('priority DESC').page(params[:page])
    else
      @tasks = Task.all.order('created_at DESC').page(params[:page])
    end
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
    params.require(:task).permit(:title,:content,:sort_expired,:status,:priority)
  end
end
