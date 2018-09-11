class ChargesController < ApplicationController
    def new 
        @stripe_btn_data = {
            key: "#{ Rails.configuration.stripe[:publishable_key] }",
            description: "Premium Membership - #{current_user.email}",
            amount: 10_00
        }
    end

    def create
        #Creates a Stripe Customer object, for associating with the charge
        customer = Stripe::Customer.create(
            email: current_user.email,
            card: params[:stripeToken]
        )

        #The charge action
        charge = Stripe::Charge.create(
            customer: customer.id,
            amount: 10_00,
            description: "Premium Membership - #{current_user.email}",
            currency: 'usd'
        )

        flash[:notice] = "Thank you for your purchase, #{current_user.email}! Please come again."
        redirect_to user_path(current_user)

        # Rescue block to catch any errors
        rescue Stripe::CardError => e 
            flash[:alert] = e.message
            redirect_to new_charge_path
    end
end
