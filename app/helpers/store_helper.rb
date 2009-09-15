module StoreHelper
  def hidden_div_if(condition, attributes = {}, &block)
    if condition
      attributes["style" ] = "display: none"
    end
    content_tag("div" , attributes, &block)
  end

  def letter_options
    $letter_options_list ||= ['#'].concat(("A".."Z").to_a)
  end

end
