class User < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :profile_picture, :profile_picture_file_name, :profile_picture_content_type, :profile_picture_file_size, :profile_picture_updated_at
  attr_accessor :updating_password
  has_many :library_records
  has_many :books, :through => :library_records, :order => "title ASC"
  has_many :received_requests, :foreign_key=>"owner_user_id", :class_name=>"Request"
  has_many :submitted_requests, :foreign_key=>"requester_user_id", :class_name=>"Request"
  has_many :locations
  has_many :favorites
  has_many :favorite_users, :through => :favorites
  has_attached_file :profile_picture,
    :styles => {
      :thumb  => "100x100",
      :medium => "200x200",
      :large => "600x400"
    },
    :storage => :s3,
    :s3_credentials => "#{Rails.root}/config/s3.yml",
    :path => ":attachment/:id/:style.:extension",
    :bucket => 'freestacks-profile-pictures'


  #validates :first_name, :last_name, :email, :password, :password_confirmation, :presence => :true
  
  #validates :password, :confirmation => :true

  validates_confirmation_of :password, :if => :should_validate_password?

  validates :password, :password_confirmation, :presence=>true, :if=> :new_record?

  validates :first_name, :last_name, :email, :presence => :true
  validates :email, :uniqueness => :true

  @password_confirmation

  def should_validate_password?
    return updating_password || new_record?
  end


  def full_name
    [first_name, last_name].join(' ')
  end
  
  def possessive
    first_name + "'" + ( (!first_name[first_name.last].eql?("s") ) ? "s " : " " )
  end

  def password
    @password
  end
  
  def password=(pw)
    @password = pw
    self.salt = rand(10000)
    self.password_digest = Digest::SHA1.hexdigest(pw + self.salt.to_s)
  end
  
  def isValid(pw)
    #puts "password digest: #{self.password_digest}"
    #puts "test digest: #{Digest::SHA1.hexdigest(pw + self.salt.to_s)}"
    #puts self.password_digest.to_s.eql?(Digest::SHA1.hexdigest(pw + self.salt.to_s)).to_s 
    self.password_digest.to_s.eql?(Digest::SHA1.hexdigest(pw + self.salt.to_s))
  end

  def defaultLocation
    Location.where(:user_id => self.id)
  end

  def to_s
    return "Email: #{self.email}, Password Digest: #{self.password_digest}, First Name: #{self.first_name}, Last Name: #{self.last_name}"
  end
  
end
