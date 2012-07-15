class User < ActiveRecord::Base
  attr_accessible :login, :name, :pass
  
  validates :login, :uniqueness => true, :presence => true
  validates :name, :pass, :presence => true
  
  has_many :permissions
  has_many :projects, :through => :permissions
end
