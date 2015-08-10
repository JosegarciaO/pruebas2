class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :timeoutable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role_id
  has_many :certificate_requests
  belongs_to :role

  validates :role_id, :presence => true

  acts_as_api
  include ApiV1::User

  def admin?
    self.role.permalink.upcase == "ADMIN"
  end

  def tecnico?
    self.role.permalink.upcase == "TECNICO"
  end

  def aduana?
    self.role.permalink.upcase == "ADUANA"
  end
  
end
