class ChargesController < ApplicationController
   
    def create
        #Creates a Stripe Customer object, for associating with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )

        #The charge action
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 15_00,
            description: "Premium Membership - #{current_user.email}",
            currency: 'usd'
        )

        current_user.role = 'premium'
        current_user.save

        flash[:notice] = "Thank you for your purchase, #{current_user.email}! You are now a #{current_user.role} member!"
        redirect_to root_path

        # Rescue block to catch any errors
        rescue Stripe::CardError => e 
            flash[:alert] = e.message
            redirect_to new_charge_path
    end

    def new 
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "Premium Membership - #{current_user.email}",
            amount: 15_00
        }
    end
end
