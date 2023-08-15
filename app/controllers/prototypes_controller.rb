class PrototypesController < ApplicationController
  protect_from_forgery
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototypes = Prototype.all
  end
  

  def new
    @prototype = Prototype.new
  end
  
  def create
    @prototype = current_user.prototypes.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end


  def show
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comments
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end
  
  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype), notice: 'プロトタイプが更新されました。'
    else
      render 'edit'
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path, notice: 'プロトタイプを削除しました。'
  end

  
  private
  
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user == @prototype.user
      redirect_to action: :index
    end
  end
  
end
