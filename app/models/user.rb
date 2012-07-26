class User < ActiveRecord::Base
  attr_accessible :login, :name, :email, :password_hash, :password_salt
  
  validates :login, :uniqueness => true, :presence => true
  
  has_many :permissions
  has_many :projects, :through => :permissions
  has_many :types, :through => :permissions
  
  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email
  validates_uniqueness_of :email

  before_save :encrypt_password
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(self.password, password_salt)
    end
  end
  
  def self.authenticate(login, password)  
    user = find_by_login(login)  
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)  
      user  
    else  
      nil  
    end  
  end 
end
