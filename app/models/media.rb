class Media < ApplicationRecord
  has_many :celebrities

  validates :title, :url, :rating, :director, presence: true

  def as_json(options = {})
    json = { :title => title, :url => url, :rating => rating, :director => director }
    json
  end
end
