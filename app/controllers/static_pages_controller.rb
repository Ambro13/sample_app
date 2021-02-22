#класс созданного контроллера статических страниц
class StaticPagesController < ApplicationController
  
  #метод "дом" 
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end

  #функция "помощь"
  def help
  end
  
  #метод "о чем"
  def about
  end
  
  #метод "контакты"
  def contact
  end
  
end
