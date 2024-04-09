Rails.application.routes.draw do
  get '/index' => 'home#index'

  # ログイン
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  namespace :api do
    namespace :v1 do
      defaults format: :json do
        # todoリスト一覧
        get '/todo_list' => 'todo_list#index'
        # todoリスト詳細
        get '/todo_list/:todo_list_item_id' => 'todo_list#show'
        # todoリスト作成
        post '/todo_list' => 'todo_list#create'
        # todoリスト更新
        post '/todo_list/:todo_list_item_id' => 'todo_list#update'
        # todoリスト削除
        delete '/todo_list/:todo_list_item_id' => 'todo_list#destroy'
      end
    end
  end
end
