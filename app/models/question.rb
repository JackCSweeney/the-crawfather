class Question < ApplicationRecord
  require 'RMagick'
  validates :question, :response, :user_id, presence: true
  belongs_to :user
  has_one_attached :image

  def make_response_image
    info = "Question: #{self.question}\nResponse: #{self.response}"
    img = Magick::ImageList.new("app/assets/images/shrimp.png")
    text = Magick::Draw.new
    text.font_family = 'helvetica'
    text.pointsize = 40
    text.gravity = Magick::CenterGravity

    text.annotate(img, 0,0,0,0, info) do |options|
      options.fill = 'white'
    end
    img = img.write("tmp/storage/response.jpg")
    self.image.attach(io: File.open("tmp/storage/response.jpg"), filename: "response.jpg", content_type: "image/jpg")
  end
end

