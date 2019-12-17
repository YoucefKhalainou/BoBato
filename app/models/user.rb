class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  after_create :welcome_send, :create_profile

  has_one :profile, dependent: :destroy
  has_many :convoys, foreign_key: 'boat_owner_id', class_name: "Convoy", dependent: :destroy
  has_many :submissions, foreign_key: 'skipper_id', class_name: "Submission", dependent: :destroy
  has_many :deliveries, foreign_key: 'skipper_id', class_name: "Delivery", dependent: :destroy
  has_many :comments, foreign_key: 'user_id', class_name: "Comment", dependent: :destroy
  has_many :received_comments, foreign_key: 'recipient_id', class_name: "Comment", dependent: :destroy

 	def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

end
