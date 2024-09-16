require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ProductsHelper. For example:
#
# describe ProductsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ProductsHelper, type: :helper do
  describe '#format_price' do
    it '価格をフォーマットする' do
      expect(helper.format_price(1000)).to eq('¥1,000')
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
