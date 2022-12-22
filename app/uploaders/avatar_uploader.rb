class AvatarUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  storage :file
  process resize_to_fill: [160, 160]

  def store_dir
    "uploads/usuario_avatars"
  end

  def filename
    @name ||= "#{model.id}_#{file_md5}#{File.extname(super)}" if super
  end

  def default_url
    ActionController::Base.helpers.asset_path("default_avatar.png")
  end

  private

  def file_md5
    Digest::MD5.hexdigest(self.read.to_s)
  end
end
