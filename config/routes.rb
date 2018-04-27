Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/db/birthday/:month/:day', to: 'birthday#show_db', as: 'birthday_db', defaults: { format: 'json' }
  get '/birthday/:month/:day', to: 'birthday#show_scrape', as: 'birthday', defaults: { format: 'json' }
end
