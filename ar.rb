class User < ActiveRecord::Base
  
  attr_accessible :user_name, :first_name, :last_name
  
  #associates
  belongs_to  :some_thing
  belongs_to  :some_thing_else, :foreign_key => 'some_thing_else_id', :class_name => "SomeThingElse"

  has_one  :address
  has_one  :profile, :through => :blah
  has_many :friends
  has_many :posts, :dependent => :destroy
  
  accepts_nested_attributes_for :user_details
  
  #events
  before_validation :adjust_user_status
  before_create :encrypt_password
  
  after_create  :adjust_user_status
  after_save    :blahas
  after_destory :blahad
  
  before_save   :blah
  before_destroy :cleanup
  
  #validations
  validates :first_name, :last_name, :presense => true

  # or class << self   end
  def self.some_static_method
  end

  def format_user_name
  end
  
  
  private
  
  def encrypt_password
    self.encrypted_password = password
  end
  
  def adjust_user_status
  end
  
end