class UsersController < ApplicationController
  
  def show
    @user = User.find(params[:id])
  end
  
  def new
    @user = User.new
  end
  
  def create
   @user = User.new(user_params)    # Не окончательная реализация!
    if @user.save
      flash[:success] = "Welcome to the Sample App!"  #Временное сообщение при успешной регистрации
      redirect_to @user             #перенаправление на страницу профиля вновь созданного пользователя 
    else                            #(можно написать - redirect_to user_url(@user). Тогда автоматически перенаправится на страницу пользователя)
      render 'new'
    end
  end
  
  ###########################################
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  #def user_params
  #    params.require(:user).permit(:name, :email, :password, :password_confirmation)
   # end
    
end