class AddCodeUrlToOrder < ActiveRecord::Migration[6.0]
  def change
    # 保存支付的 code_url 这样可以回头再来支付 而不是第一次没支付 页面关了就再也没法支付了
    add_column :orders, :code_url, :string
  end
end
