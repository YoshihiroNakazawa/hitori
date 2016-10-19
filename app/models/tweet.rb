class Tweet < ActiveRecord::Base
  validates :content, 
    presence: true,
    length: { maximum: 20 }
end
