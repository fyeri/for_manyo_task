class TasksController < ApplicationController
 before_action :set_task, only: %i[:show, :edit, :update, :destroy]
  before_action :authorize_user, only: [:show, :edit, :update, :destroy]

def index
  @tasks = Task.filtered_list(params, current_user).page(params[:page]).per(10)
end


def show
end

def new
  @task = Task.new
end

def edit
end

def create
  @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_path, notice: t('common.task_created') 
    else
      render :new 
    end
  end
end

def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: t('common.task_updated') 
    else
      render :edit
    end
  end

def destroy
  @task.destroy
  redirect_to tasks_path, notice: t('common.task_destroyed') 
end


 private

 def set_task
   @task = Task.find(params[:id])
 end

 def authorize_user
  unless current_user == @task.user
    flash[:alert] = 'アクセス権限がありません'
    redirect_to tasks_path
  end
end
 
 def task_params
   params.require(:task).permit(:title, :content, :deadline_on, :priority, :status )
 end

 def require_login
  unless session[:user_id]
    flash[:error] = “ログインしてください”
    redirect_to login_path
  end
end

