class HomeController < ApplicationController
  def index
    @orders = Order.all
  end

  # "统一下单" https://pay.weixin.qq.com/wiki/doc/api/native.php?chapter=9_1
  def unifiedorder
    @order = Order.create
    url = "https://api.mch.weixin.qq.com/pay/unifiedorder"

    info = {
      nonce_str: SecureRandom.uuid.tr("-", ""),
      body: "商品名-如口红", # 商品名(会显示给用户看)
      notify_url: "https://wechat-pay-rails-demo.herokuapp.com/notify", # 回调 URL
      out_trade_no: "out_trade_no-#{@order.id}", # 商户内部自己的订单号
      spbill_create_ip: "127.0.0.1",
      total_fee: 1, # 以分为单位的价格
      trade_type: "NATIVE", # 二维码支付
    }
    ## 在这里填入 ##
    whole_params = {
      key: "xxxcy111VBdxxxrNqn11BcF6bZDH9xxx", #[填入商户平台自己设置的 32 位 key]
      appid: "wxxxx791111402xxxx", # [填入与商户号绑定的公众号/小程序 appid]
      mch_id: "149xxx18xx", # [填入商户 id]
    }.merge(info)

    r = RestClient::Request.execute(
      {
        method: :post,
        url: url,
        payload: make_payload(whole_params),
        headers: { content_type: "application/xml" },
      }
    )
    @result = Hash.from_xml(r)
    # 保存 code_url, 方便以后再来支付
    @order.code_url = @result["xml"]["code_url"]
    @order.save
  end

  # 返回签名
  def get_sign(params)
    key = params.delete(:key)
    query = params.sort.map do |k, v|
      "#{k}=#{v}" if v.to_s != ""
    end.compact.join("&")
    Digest::MD5.hexdigest("#{query}&key=#{key}").upcase
  end

  # 返回 XML
  def make_payload(params)
    sign = get_sign(params)
    params.delete(:key) if params[:key]
    "<xml>#{params.map { |k, v| "<#{k}>#{v}</#{k}>" }.join}<sign>#{sign}</sign></xml>"
  end
end
