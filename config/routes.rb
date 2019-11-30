Rails.application.routes.draw do
  get "/order/:id", to: "order#show" # 显示单个订单

  root "home#index" # 首页

  get "home/unifiedorder" # 下订单

  post "notify" => "weixin#notify" # 接收微信回调通知
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
