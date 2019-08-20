class GroupsController < ApplicationController
  before_action :set_group, only:[:show,:edit,:update,:destroy]
  before_action :group_user, only:[:show]
  before_action :admin_user, only:[:edit,:destroy]

  def index
    @groups = Group.all
  end

  def show
    @users = @group.users
    count(@users)
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      current_user.user_groups.create(group_id: @group.id)
      flash[:success] ="Create new group!"
      redirect_to groups_path
    else
      flash[:danger] ="Failed.."
      render 'new'
    end
  end

  def edit
  end

  def update
    if @group.update(group_params)
      flash[:success] ="Edit group!"
      redirect_to groups_path
    else
      flash[:danger] ="Failed.."
      render 'edit'
    end
  end

  def destroy
    @group.destroy
    flash[:danger] ="Deleted!"
    redirect_to groups_path
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name,:user_id)
  end

  def admin_user
    unless @group.user_id == current_user.id
      redirect_back(fallback_location: root_path)
    end
  end

  def group_user
    unless @group.user_groups.pluck(:user_id).include?(current_user.id)
      redirect_back(fallback_location: root_path)
    end
  end
end
