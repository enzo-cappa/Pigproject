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

  def image_for_edit(entity)
    link_to(image_tag("/images/edit.png", {:alt => 'edit', :class => 'linkimage'}),{ :controller => entity.class.name.pluralize(), :action => 'edit', :id => entity.id })
  end

  def image_for_show(entity)
   # link_to(image_tag("/images/show.png", {:alt => 'show', :class => 'linkimage'}), entity)
  end

  def image_for_destroy(entity)
    #link_to(image_tag("/images/destroy.png", {:alt => 'destroy', :class => 'linkimage' }), entity, :confirm => 'Are you sure?', :method => :delete )
  end

end
