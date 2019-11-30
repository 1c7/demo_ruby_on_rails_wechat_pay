module ApplicationHelper
  def order_status(name)
    if name == "unpaid"
      return "未支付"
    elsif name == "paid"
      return "已支付"
    elsif name == "refuned"
      return "已退款"
    end
  end
end
