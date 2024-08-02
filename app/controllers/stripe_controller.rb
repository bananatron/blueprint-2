class Api::StripeController < ApplicationController
  # before_action :api_authenticate_user!
  skip_before_action :verify_authenticity_token, only: [:webhooks]

  def webhooks
    endpoint_secret = ENV['STRIPE_TOKEN_WEBHOOK_SECRET']
    sig_header = request.env['HTTP_STRIPE_SIGNATURE']
    payload = request.body.read
    event = nil

    raise "No endpoint_secret for #{self.class.name}" if endpoint_secret.nil?
    raise "No sig_header for #{self.class.name}" if sig_header.nil?
    raise "No payload for #{self.class.name}" if payload.nil?

    begin
      event = Stripe::Webhook.construct_event(
        payload, sig_header, endpoint_secret
      )
    rescue JSON::ParserError => err
      Sentry.capture_exception(err)
      return head :bad_request
    rescue Stripe::SignatureVerificationError => err
      Sentry.capture_exception(err)
      return head :bad_request
    end

    # Handle the event
    # (These events are defined in the stripe webook setup so they are not arbitrary)
    case event.type
    when 'charge.refunded' # Not sure if we care about this really (or even possible) but can remove if uneeded later
      charge = event.data.object
      Sentry.capture_message("Charge refunded: #{charge.id}")
    when 'checkout.session.completed' # Checkout completed (via payment link, for example)
      session = event.data.object # Stripe::Checkout::Session


      client_reference_id = session.client_reference_id # User ID (UUID) passed via payment link on tokens purchase page
      raise "No client_reference_id for #{self.class.name}" if client_reference_id.nil?

      user = User.find_by(id: client_reference_id)
      raise "No user for client_reference_id #{client_reference_id}" if user.nil?

      # Verify that this payment link still exists
      payment_link_id = session.payment_link # Payment ID string (not the url)
      payment_link_in_stripe = Stripe::PaymentLink.list.any? do |payment_link|
        payment_link.id == payment_link_id
      end
      raise "No payment link in Stripe for #{payment_link_id}" unless payment_link_in_stripe

      product_set = StripeCharges::TOKEN_PURCHASE_LINKS[Rails.env.to_sym].values.find do |link|
        link[:plink] == payment_link_id
      end
      raise "No product set for Stripe payment_link_id: #{payment_link_id}" if product_set.nil?

      # Perform checkout logic
    else
      puts "Unhandled event type: #{event.type}"
    end

    head :ok
  end

end
