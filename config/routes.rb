Rails.application.routes.draw do
  post  '/receive',  to: 'vaccination_forms#receive'
end
