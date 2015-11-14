Rails.application.routes.draw do
  get 'passwords' => 'passwords#start'
  post 'passwords' => 'passwords#start_matches'
  post 'passwords/match' => 'passwords#try_matches'

  root "passwords#start"
end
