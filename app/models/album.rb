class Album < ActiveRecord::Base
  has_many :images

  validates :name, length: { minimum: 5, maximum: 50 }
  validates_uniqueness_of :name
end
