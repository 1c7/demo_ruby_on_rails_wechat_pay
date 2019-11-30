class OrderController < ApplicationController
  def show
    id = params[:id]
    @order = Order.find(id)
  end
end
