module ProductsHelper
  def link_to_sell_prices_popup(product_id)
    link_to_popup ("/sell_prices/new?product=" + product_id.to_s)
  end

  def link_to_buy_prices_popup(product_id)
    link_to_popup ("/buy_prices/new?product=" + product_id.to_s )
  end

  def link_to_popup(url)
    "<a href=\"#\" onclick=\"var win = new Window({className: 'alphacube', title: 'Prices', top:window.pageYOffset, left:100, width:300, height:200, url: '" + url + "', showEffectOptions: {duration:1.5}, destroyOnClose: 'true'}); win.showCenter();return false;\">New</a>"
  end
end
