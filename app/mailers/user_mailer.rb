class UserMailer < ApplicationMailer
  def request_email(address)
    @email_address = address

    mail(to: 'chris@chrismar035.com', subject: "Commish App User Request")    
  end
end
