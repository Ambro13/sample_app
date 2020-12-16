Rails.application.routes.draw do
  
  root                'static_pages#home' # меняет URL static_pages/home на пару контроллер-действие static_pages#home, которая обеспечивает направление запроса GET для / к действию home в контроллере StaticPages.
  get '/help',    to: 'static_pages#help' # Правило направляет запрос для URL /static_pages/help к действию home в контроллере StaticPages.
  get '/about',   to: 'static_pages#about' # Правило направляет запрос для URL /static_pages/about к действию home в контроллере StaticPages.
  get '/contact', to: 'static_pages#contact'
  get 'users/new'
  get 'signup'  => 'users#new'
  
end
