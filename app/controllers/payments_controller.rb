class PaymentsController < ApplicationController
  def pay
    issuer = Issuer.find_by_pan(params[:pan])
    payment = Payment.create(pan: params[:pan],
                             security_code: params[:security_code],
                             card_holder_name: params[:card_holder_name],
                             expiry_date: params[:expiry_date],
                             acquirer_order_id: params[:acquirer_order_id],
                             acquirer_order_timestamp: params[:acquirer_order_timestamp],
                             amount: params[:amount])

    issue_it_body = {
      pan: params[:pan],
      security_code: params[:security_code],
      card_holder_name: params[:card_holder_name],
      expiry_date: params[:expiry_date],
      acquirer_order_id: params[:acquirer_order_id],
      acquirer_order_timestamp: params[:acquirer_order_timestamp],
      amount: params[:amount]
    }

    resp = HTTParty.post(
      'http://localhost:6000/payments/pay',
      body: issue_it_body,
      timeout: 5
    )

    if resp.code == 200
      body = JSON.parse resp.body
      payment.update(issuer_order_id: body["issuer_order_id"],
                     issuer_order_timestamp: body["issuer_order_timestamp"])

      render json: { acquirer_order_id: params[:acquirer_order_id],
                     acquirer_order_timestamp: params[:acquirer_order_timestamp],
                     issuer_order_id: payment.issuer_order_id,
                     issuer_order_timestamp: payment.issuer_order_timestamp }
    else
      render json: { error: true }, status: :not_found
    end
  end
end
