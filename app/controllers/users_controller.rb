class UsersController < ApplicationController
  before_action :correct_user, only: [:show]
  skip_before_action :login_required, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = "アカウントを登録しました"
      redirect_to tasks_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
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
    @user = User.find(params[:id])
    if @user.destroy
    flash[:notice] = '本当に削除してもよろしいですか?'
    redirect_to  user_path
  else
    render :edit
  end
end

  private
  
  def correct_user
    @user = User.find(params[:id])
    unless current_user?(@user)
      flash[:alert] = 'アクセス制限がありません'
    redirect_to current_user 
    end
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end