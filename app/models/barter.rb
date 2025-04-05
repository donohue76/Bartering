class Barter < ActiveRecord::Base
  belongs_to :user

  # validates :zip, numericality: { only_integer: true }

  has_many :comments

  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
  size: { in: 0..10.megabytes }

  validates :category, presence: true
  validates :expiration, presence: true
  validates :product, presence: true
  validates :description, presence: true
  validates :neighborhood, presence: true
  validates :interested_in, presence: true



  validates_date :expiration, :timeliness => {:on_or_after => lambda { Date.today }, :type => :date}
end
