class User < ActiveRecord::Base
  attr_accessible :login, :name, :pass
  
  has_many :permissions
  has_many :projects, :through => :permissions
end
