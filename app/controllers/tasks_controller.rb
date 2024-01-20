class TasksController < ApplicationController
 before_action :set_task, only: [:show, :edit, :update, :destroy]

def index
  # @tasks = Task.all.order(created_at: "DESC").page(params[:page]).per(10)

  @tasks = if params[:sort_deadline_on]
    Task.latest.page(params[:page]).per(10)
  elsif params[:sort_priority]
    Task.expensive.page(params[:page]).per(10)
  else
    Task.all.order(created_at: :desc).page(params[:page]).per(10)
  end
end

def show
end

def new
  @task = Task.new
end

def edit
end

def create
  @task = Task.new(task_params)

  respond_to do |format|
    if @task.save
      format.html { redirect_to tasks_path, notice: t('common.task_created') }
      format.json { render :show, status: :created, location: @task }
    else
      format.html { render :new }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end
end

def update
  respond_to do |format|
    if @task.update(task_params)
      format.html { redirect_to @task, notice: t('common.task_updated') }
      format.json { render :show, status: :ok, location: @task }
    else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @task.errors, status: :unprocessable_entity }
    end
  end
end


def destroy
  @task.destroy
    respond_to do |format|
      format.html { redirect_to tasks_url, notice: t('common.task_destroyed') }
      format.json { head :no_content }
    end
  end
end



 private

 def set_task
   @task = Task.find(params[:id])
 end

 def task_params
   params.require(:task).permit(:title, :content, :deadline_on, :priority, :status )
 end

