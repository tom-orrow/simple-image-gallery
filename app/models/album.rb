class Album < ActiveRecord::Base
  attr_accessible :name
  attr_accessible :desc
  has_many :images
  validates_presence_of :name
  validates_uniqueness_of :name
end
