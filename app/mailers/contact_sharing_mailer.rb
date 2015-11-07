class ContactSharingMailer < ApplicationMailer
  def share_contact(contact_id, email)
    @contact = Contact.find(contact_id)
    mail(to: email)
  end
end
