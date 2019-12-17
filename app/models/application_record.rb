class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true


  def check_skipper_availability

		# Find all convoys in which skipper is involved
		skipper_deliveries = Delivery.where(:skipper_id => self.skipper)
		current_start = self.convoy.date_of_departure
		current_end = self.convoy.date_of_departure
		skipper_available = true

		if skipper_deliveries.empty?
			return skipper_available
		else
			# For each one check if the skipper is available
			skipper_deliveries.each do |delivery|
				undercheck_start = delivery.convoy.date_of_departure
				undercheck_end = delivery.convoy.date_of_departure
				if undercheck_start <= current_end && undercheck_end >= current_start
					skipper_available = false
				end	
			end
		end
		return skipper_available	
	end

end
