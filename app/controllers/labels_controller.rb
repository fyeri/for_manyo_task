class LabelsController < ApplicationController
  before_action :set_label, only: [:show, :edit, :update, :destroy]

  def index
    @labels = current_user.labels
  end

  def edit
  end

  def new
    @label = Label.new
  end

  def create
    @label = current_user.labels.build(label_params)
    if @label.save
      flash[:notice] = "ラベルを登録しました"
      redirect_to labels_path
    else
      render :new
    end
  end

  def show
  end

  def update
    if @label.update(label_params)
      flash[:notice] = "ラベルを更新しました"
      redirect_to labels_path
    else
      render :edit
    end
  end

  def destroy
    @label.destroy
    flash[:notice] = "ラベルを削除しました"
    redirect_to labels_path
  end

  private

  def set_label
    @label = Label.find(params[:id])
  end

  def label_params
    params.require(:label).permit(:name)
  end
end