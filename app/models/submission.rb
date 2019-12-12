class Submission < ApplicationRecord
	belongs_to :convoy
	belongs_to :skipper, class_name: "User"

	validate :skipper_must_be_available_before_submit
	after_create :submission_conf_email_send,


	def skipper_must_be_available_before_submit
	  errors.add(:skipper_id, "Vous ne pouvez pas participer à ce convoyage car vous êtes déjà engagé sur un autre convoyage aux même dates") unless check_skipper_availability
	end

	def submission_conf_email_send
    UserMailer.submission_conf_email(self, self.skipper).deliver_now
    UserMailer.submission_conf_email(self, self.convoy.boat_owner).deliver_now
  end

end
