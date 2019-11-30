# == Schema Information
#
# Table name: orders
#
#  id           :bigint           not null, primary key
#  code_url     :string
#  product_name :string
#  status       :integer          default("unpaid"), not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class Order < ApplicationRecord
  # 订单 Model
  # product_name 产品名

  # 状态
  enum status: {
    unpaid: 0,  # 未支付
    paid: 1,    # 已支付
    refund: 2,  # 已退款
  }
end
