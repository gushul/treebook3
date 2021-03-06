class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :statuses
  has_many :user_friendships

  #this shit is crazy
  has_many :friends, -> { where user_friendships: { state: 'accepted'} }, through: :user_friendships  
  has_many :pending_user_friendships, -> {where state: 'pending'}, class_name: 'UserFriendship', foreign_key: :user_id
  has_many :pending_friends, through: :pending_user_friendships, source: :friend

  def full_name
  	first_name + " " + last_name
  end

  #def to_param
    #profile_name
  #end

  def gravatar_url
  	stripped_email = email.strip
  	downcased_email = stripped_email.downcase
  	hash = Digest::MD5.hexdigest(downcased_email)

  	"http://www.gravatar.com/#{hash}" 
  end
  
  
end
