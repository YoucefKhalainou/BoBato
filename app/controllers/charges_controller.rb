class ChargesController < ApplicationController

	def new
	end

	def create
		puts '$'*40
		puts params.inspect
		puts '$'*40
	  @my_convoy = Convoy.find(params[:convoy_id])
	  @skipper = User.find(params[:skipper_id])
		@submissions = Submission.where(convoy: @my_convoy)
	  # Amount in cents
	  @amount = (@my_convoy.convoy_price * 100).to_i

	  customer = Stripe::Customer.create({
	    email: params[:stripeEmail],
	    source: params[:stripeToken],
	  })

	  charge = Stripe::Charge.create({
	    customer: customer.id,
	    amount: @amount,
	    description: 'Rails Stripe customer',
	    currency: 'eur',
	  })

	  # Create new delivery for the considered convoy, with the selected skipper
		@delivery = Delivery.new.after_checkout(@my_convoy, @skipper, params[:stripeToken])
		if @delivery.save
      flash[:success] = "Convoyage validé"
      @my_convoy.update_submissions_status_after_checkout(@skipper)
      redirect_to request.referrer   
    else
      flash[:errors] = @delivery.errors.full_messages
      redirect_to request.referrer
    end
	end

end
