module ProductsHelper
  def format_price(price)
    "¥#{price.to_fs(:delimited)}"
  end
end
