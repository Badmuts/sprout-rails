class AdvertisementPhotoSerializer < ActiveModel::Serializer
  attributes :id, :photo

  def photo
    URI.join(instance_options[:base_url], object.photo.url(:small))
  end
end
