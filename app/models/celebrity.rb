class Celebrity < ApplicationRecord
  belongs_to :media

  validates :name, :photo_url, :profile_url, :birth_month, :birth_day, presence: true

  def as_json(options = {})
    json = { :name => name, :profileUrl => profile_url, :photoUrl => photo_url }
    json[:mostKnownWork] = media.as_json(options) if options[:include_media]
    json
  end

end
