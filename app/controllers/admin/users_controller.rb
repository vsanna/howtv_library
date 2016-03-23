class Admin::UsersController < ApplicationController
  def index
    @users = User.all.order(created_at: :desc).paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice:'追加しました'
    else
      render 'new', alert:'追加できませんでした'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to admin_users_path, notice:'更新しました'
    else
      render 'edit', alert: '更新できませんでした'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
  end

  private
  def user_params
    params.require(:user).permit(:id, :family_name, :given_name, :email, :role)
  end
end
