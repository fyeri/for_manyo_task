class Admin::UsersController < ApplicationController
  before_action :admin_user
  skip_before_action :login_required, only: [:new, :create]
  before_action :set_user, only: [:show, :edit, :destroy]


  def index
    @users = User.all
  end

  def create
    @user=User.new(user_params)
      if @user.save
        @user.update(admin: true)
        log_in @user
      redirect_to items_path
    else
      render 'new'
      end
  end

  def new
    @user=User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def show
    @tasks = @user.tasks
  end

  def update
       @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "アカウントを更新しました"
      redirect_to  user_path(id: params[:id])
    else
      render :edit
    end
  end

  def destroy
  end

private
  def admin_user
    unless current_user.admin?  
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
end
