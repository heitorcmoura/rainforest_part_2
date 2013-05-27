class Review < ActiveRecord::Base
  attr_accessible :comment, :product_id, :user_id

  belongs_to :product
  belongs_to :user

  validates_presence_of :comment, :product, :user
end
