Rails.application.routes.draw do
  get 'users/new'
  root             'static_pages#home' # меняет URL static_pages/home на пару контроллер-действие static_pages#home, которая обеспечивает направление запроса GET для / к действию home в контроллере StaticPages.
  get 'help'    => 'static_pages#help' as: static_pages_help # Правило направляет запрос для URL /static_pages/help к действию home в контроллере StaticPages.
  get 'about'   => 'static_pages#about' # Правило направляет запрос для URL /static_pages/about к действию home в контроллере StaticPages.
  get 'contact' => 'static_pages#contact'
  get 'signup'  => 'users#new'
  
end
