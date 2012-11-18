class User < ActiveRecord::Base
  # se quita los parametros de password_hash y password_salt por cuestiones de seguridad
  attr_accessible :login, :name, :email
  
  validates :login, :uniqueness => true, :presence => true
  
  has_many :permissions
  has_many :projects, :through => :permissions
  has_many :types, :through => :permissions
  
  attr_accessor :password, :password_confirmation
  validates_confirmation_of :password
  validates :password, :on => :create, :presence => true
  validates :email, :presence => true
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
