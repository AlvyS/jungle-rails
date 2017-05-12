class UserMailer < ApplicationMailer
    default from: 'no_reply@jungle.com'

    def email_receipt(order)
        @orderVar = order
        mail(to: order.email, subject: "Your order number is #{order.id}") do |format|
            format.html { render "email_receipt" }
            format.text { render "email_receipt" }
        end
    end

end