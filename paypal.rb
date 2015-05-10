# #CreatePayment using credit card Sample
# This sample code demonstrate how you can process
# a payment with a credit card.
# API used: /v1/payments/payment
require 'paypal-sdk-rest'

module Paypal
  include PayPal::SDK::REST
  include PayPal::SDK::Core::Logging

  def self.make_payment(product_id, product_name, product_price, product_currency, product_quantity)
    # ###Payment
    # A Payment Resource; create one using
    # the above types and intent as `sale or `authorize`
    @payment = Payment.new({
      :intent => "sale",

      # ###Payer
      # A resource representing a Payer that funds a payment
      # Use the List of `FundingInstrument` and the Payment Method
      # as 'credit_card'
      :payer => {
        :payment_method => "credit_card",

        # ###FundingInstrument
        # A resource representing a Payeer's funding instrument.
        # Use a Payer ID (A unique identifier of the payer generated
        # and provided by the facilitator. This is required when
        # creating or using a tokenized funding instrument)
        # and the `CreditCardDetails`
        :funding_instruments => [{

          # ###CreditCard
          # A resource representing a credit card that can be
          # used to fund a payment.
          :credit_card => {
            :type => "visa",
            :number => "4020025212076561",
            :expire_month => "05",
            :expire_year => "2020",
            :cvv2 => "874",
            :first_name => "Joe",
            :last_name => "Shopper",

            # ###Address
            # Base Address used as shipping or billing
            # address in a payment. [Optional]
            :billing_address => {
              :line1 => "52 N Main ST",
              :city => "Johnstown",
              :state => "OH",
              :postal_code => "43210",
              :country_code => "US" }}}]},
      # ###Transaction
      # A transaction defines the contract of a
      # payment - what is the payment for and who
      # is fulfilling it.
      :transactions => [{

        # Item List
        :item_list => {
          :items => [{
            :name => product_name,
            :sku => product_id,
            :price => product_price,
            :currency => product_currency,
            :quantity => product_quantity }]},

        # ###Amount
        # Let's you specify a payment amount.
        :amount => {
          :total => product_price,
          :currency => product_currency },
        :description => "Payment towards purchase of #{product_name}" }]})

    # Create Payment and return status( true or false )
    if @payment.create
      msg = "Payment[#{@payment.id}] created successfully"
      puts msg
      true
    else
      # Display Error message
      msg = "Error while creating payment"
      pust msg
      false
    end
  end
end
