class Delivery < ApplicationRecord
	belongs_to :skipper, class_name: 'User'
	belongs_to :convoy

	validate :skipper_must_be_available_for_this_convoy
	after_create :delivery_conf_email_send, :delivery_to_admin_email_send,


	def skipper_must_be_available_for_this_convoy
	  errors.add(:skipper_id, "Le skipper choisi n'est plus disponible pour les dates selectionnées") unless check_skipper_availability
	end


	def delivery_conf_email_send
    UserMailer.delivery_conf_email(self, self.skipper).deliver_now
    UserMailer.delivery_conf_email(self, self.convoy.boat_owner).deliver_now
  end


	def delivery_to_admin_email_send
    UserMailer.delivery_to_admin_email(self).deliver_now
  end

  def after_checkout(convoy, skipper, token)
	  Delivery.new(
								skipper: skipper, 
								convoy: convoy,
								stripe_id: token,
								)
  end

end
