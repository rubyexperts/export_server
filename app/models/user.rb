class User < ActiveRecord::Base
 
  has_many :expenses
  has_many :items
    
  accepts_nested_attributes_for :expenses
  accepts_nested_attributes_for :items 
  
  attr_accessor :password, :password_confirmation
  # attr_accessible :username, :password, :display_name, :email, :user_level
  attr_protected :hashed_password, :salt
  
  validates_presence_of :username, :password, :password_confirmation
  validates_uniqueness_of :username
  
  def validate
  	unless @password_confirmation == @password
  		errors.add('password','and confirmation do not match')
  	end
	unless @password.length >= 6
  	errors.add('password','Minimum length required is 6 characters')
  	end

  end	


  	
	def before_create
	  self.salt = User.make_salt(self.username)
    self.hashed_password = User.hash_with_salt(@password, self.salt)
  end
  
	def before_update
	  if !@password.blank? 
  	  self.salt = User.make_salt(self.username) if self.salt.blank?
      self.hashed_password = User.hash_with_salt(@password, self.salt)
    end
  end
  
  def after_save
    @password = nil
  end
  
  def before_destroy
    return false if self.id == 1
  end
  
  # Returns the user's first name and last name joined with a space.
	def full_name
	  # this is an inside comment
		self.first_name + " " + self.last_name
	end
	
	def self.authenticate(username = "", password = "")
    user = self.find(:first, :conditions => ["username = ?", username])
    return (user && user.authenticated?(password)) ? user : nil
  end
  
  def authenticated?( password = "" )
    self.hashed_password == User.hash_with_salt(password, self.salt)
  end
  
	private #----------------
  
  def self.make_salt( string )
	  return Digest::SHA1.hexdigest(string.to_s + Time.now.to_s)
  end
	
  def self.hash_with_salt(password, salt)
    return Digest::SHA1.hexdigest("Put #{salt} on the #{password}")
  end
end
