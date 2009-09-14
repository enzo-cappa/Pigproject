# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def image_for(product, size = :medium)
    if product.product_image
      product_image  = product.product_image.public_filename(size)
      link_to image_tag(product_image),  product.product_image.public_filename
    else
      image_tag("blank-product-#{size}.png" )
    end
  end
end