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

require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
