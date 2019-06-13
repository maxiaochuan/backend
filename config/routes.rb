Rails.application.routes.draw do

  scope '/api' do

    post '/login' => 'main#login'


    resources :users
    post "/graphql", to: "graphql#execute"

    if Rails.env.development?
      mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
