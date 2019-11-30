class WeixinController < ApplicationController
  skip_before_action :verify_authenticity_token # 这行很重要

  def notify
    result = Hash.from_xml(request.body.read)["xml"]
    if WxPay::Sign.verify?(result)
      logger.debug "--------开始--------"
      logger.debug result
      logger.debug "--------结束--------"
      # 拿到订单号
      out_trade_no = result["out_trade_no"]
      out_trade_no = out_trade_no.split("-")[1]
      # 找到记录
      order = Order.find_by(id: out_trade_no)
      # 改为已支付
      order.paid!
      render :xml => { return_code: "SUCCESS" }.to_xml(root: "xml", dasherize: false)
    else
      render :xml => { return_code: "FAIL", return_msg: "签名失败" }.to_xml(root: "xml", dasherize: false)
    end
  end
end
