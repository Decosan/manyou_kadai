class TasksController < ApplicationController
  before_action :set_params, only:[:show,:edit,:update,:destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only:[:show,:edit,:update,:destroy]

  def index
    # @labels = Label.pluck(:title)
    if params[:task] && params[:task][:search]
      if params[:task][:title].present? && params[:task][:status].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).status_search(params[:task][:status]).page(params[:page])
      elsif params[:task][:title].present?
        @tasks = current_user.tasks.title_search(params[:task][:title]).page(params[:page])
      elsif params[:task][:status].present?
        @tasks = current_user.tasks.status_search(params[:task][:status]).page(params[:page])
      elsif params[:task][:label_ids].present?
        # binding.pry
        @tasks = current_user.tasks.joins(:task_labels).where('task_labels.label_id = ?', params[:task][:label_ids]).page(params[:page])
      end
    elsif params[:sort_expired]
      @tasks = current_user.tasks.nil_limit.limit_sort.page(params[:page])
    elsif params[:sort_priority]
      @tasks = current_user.tasks.order('priority DESC').page(params[:page])
    else
      @tasks = current_user.tasks.all.order('created_at DESC').page(params[:page])
    end
  end

  def show
  end

  def new
    @task = Task.new
  end

  def create
    @task = current_user.tasks.build(task_params)
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
    params.require(:task).permit(:title,:content,:sort_expired,:status,:priority,label_ids: [])
  end

  def correct_user
    unless current_user.id == @task.user.id
      redirect_to new_session_path
    end
  end
end
