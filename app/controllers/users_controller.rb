class UsersController < ApplicationController
  before_action :logged_in_user, only: [:index, :edit, :update,:destroy] #before_action для указания конкретному методу на то, что он должен быть вызван до заданных действий.
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy,
                                        :following, :followers]
  
  def index
    @users = User.paginate(page: params[:page])
  end
  
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)    # Не окончательная реализация!
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"  #Временное сообщение при успешной регистрации
      redirect_to @user             #перенаправление на страницу профиля вновь созданного пользователя 
    else                            #(можно написать - redirect_to user_url(@user). Тогда автоматически перенаправится на страницу пользователя)
      render 'new'
    end
  end
  
   def edit
    @user = User.find(params[:id])
   end
  
   def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
   end
   
    def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
    end
  
    def following
      @title = "Following"
      @user  = User.find(params[:id])
      @users = @user.following.paginate(page: params[:page])
      render 'show_follow'
    end
  
    def followers
      @title = "Followers"
      @user  = User.find(params[:id])
      @users = @user.followers.paginate(page: params[:page])
      render 'show_follow'
    end
  ###########################################
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  #def user_params
  #    params.require(:user).permit(:name, :email, :password, :password_confirmation)
   # end
   
    # Предфильтры

    # Подтверждает вход пользователя
    def logged_in_user
      unless logged_in?
        store_location  #помещает запрашиваемый URL в переменную session под ключом :forwarding_url
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
       # Подтверждает правильного пользователя
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
    
    # Подтверждает администратора.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
end