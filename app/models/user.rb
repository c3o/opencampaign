require 'digest/sha1'
class User < ActiveRecord::Base
  belongs_to :town
  has_one :video, :dependent => :destroy
  has_many :comments, :dependent => :destroy
  has_many :projects
  has_and_belongs_to_many :task

  #validates_presence_of     :town, :message => 'ist nicht in der Datenbank'
  validates_presence_of      :email, :message => 'darf nicht leer sein'
  #validates_uniqueness_of   :email, :case_sensitive => false, :message => 'ist bereits vorhanden'
  
  # prevents a user from submitting a crafted form that bypasses activation
  # anything else you want your user to change should be added here.
  attr_accessible :name, :email, :town, :facebook_id
  attr_accessor :password
  
  before_save :encrypt_password
  
  def name
    super || self.email.split('@')[0]
  end
  
  def town=(name)
    if !name.blank?
      # Take only the part before parenthesis (containing wahlkreis)
      clean_name = name.split("(",2).first.strip
      t = Town.find_by_name(clean_name)
      # Assign right township id by name
      self.town_id = t.id if t
    end
  end

  # Authenticates a user by their login name and unencrypted password.  Returns the user or nil.
  def self.authenticate(email, password)
    user = self.find_by_email(email)
    if user && (user.crypted_password == user.encrypt(password))
      user
    else
      nil
    end
  end

  def self.encrypt(password, salt)
    Digest::SHA1.hexdigest("--#{salt}--#{password}--")
  end
  
  # Encrypts the password with the user salt
  def encrypt(password)
    self.class.encrypt(password, salt)
  end
  
  def self.random_password(len=10)
    #generate a random password consisting of strings and digits
    chars = ("a".."z").to_a + ("A".."Z").to_a + ("0".."9").to_a
    newpass = ""
    1.upto(len) { |i| newpass << chars[rand(chars.size-1)] }
    return newpass
  end
protected
  # before filter 
  def encrypt_password
    @password = User.random_password if new_record? 
    if @password
      self.salt = Digest::SHA1.hexdigest("--#{Time.now.to_s}--#{email}--") if new_record?
      self.crypted_password = encrypt(password)
    end
  end
end
