class TasksController < ApplicationController
 before_action :set_task, only: [:show, :edit, :update, :destroy]

def index
  @tasks = Task.all.order(id: "DESC")
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
   params.require(:task).permit(:title, :content)
 end

