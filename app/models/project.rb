class Project < ActiveRecord::Base
  attr_accessible :description, :name
  
  validates :name, :uniqueness => true

  has_many :permissions
  has_many :users, :through => :permissions
end
