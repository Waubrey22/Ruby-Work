class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/'
    end
  end

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def index
    @users = User.all
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
      redirect_to @user
    else
      render :action => 'edit'
    end
  end

  def delete
    @user = User.find(params[:id])
  end

  def remove

  end
end
