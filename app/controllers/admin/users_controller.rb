class Admin::UsersController < ApplicationController
  before_action :admin_user
  before_action :set_user, only: [:show, :edit, :destroy]
  skip_before_action :login_required, only: [:new, :create]


  def index
    @users = User.includes(:tasks).all
  end

  def create
    @user = User.new(user_params)
      if @user.save
        flash[:success] = "ユーザを登録しました"
      redirect_to admin_users_path
    else
      render 'new'
    end
  end

  def new
    if logged_in? && !current_user.admin?
      flash[:warning] = 'ログアウトしてください'
      redirect_to tasks_path
    elsif !logged_in?
      flash[:warning] = 'ログインしてください'
      redirect_to new_session_path
    else
      @user = User.new
    end
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
      flash[:notice] = "ユーザを更新しました"
      redirect_to  admin_users_path
    else
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to  admin_users_path
      flash[:notice] = "ユーザを削除しました"
   else
      render :edit
    end
  end

private
  def admin_user
    unless logged_in? && current_user.admin?
      flash[:alert] = '管理者以外アクセスできません' 
      redirect_to tasks_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
  end
end
