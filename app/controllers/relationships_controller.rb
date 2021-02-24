class RelationshipsController < ApplicationController
  before_action :logged_in_user

  #создание связи читаемого
  def create
    user = User.find(params[:followed_id])
    current_user.follow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  #уничтожение связи читаемого
  def destroy
    user = Relationship.find(params[:id]).followed
    current_user.unfollow(user)
    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end
  
end
