class ProductImage < ActiveRecord::Base
  belongs_to :product
  has_attachment :content_type => :image,
  :storage => :file_system,
  :max_size => 500.kilobytes,
  :path_prefix => 'public/images/products_images',
  :resize_to => '300x300>',
  :processor => :Rmagick,
  :thumbnails => {
    :large => '150x150>' ,
    :medium => '100x100>' ,
    :small => '64x64>'
  }



  validates_as_attachment

  def full_filename(thumbnail = nil)
    file_system_path = (thumbnail ? thumbnail_class : self).attachment_options[:path_prefix]
    case self.thumbnail
    when "thumb"
      File.join(RAILS_ROOT, file_system_path, 'thumb', thumbnail_name_for(thumbnail, self.parent_id))
    else
      File.join(RAILS_ROOT, file_system_path, 'fullsize', thumbnail_name_for(thumbnail_name_for, self.id))
    end
  end

  def thumbnail_name_for(thumbnail = nil, asset = nil)
    extension = filename.scan(/\.\w+$/)
    return "#{asset}#{extension}"
  end

end
