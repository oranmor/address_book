describe ContactSharingMailer, type: :mailer do
  describe '#share_contact' do
    let(:contact) { create(:contact) }
    let(:email) { Faker::Internet.email }
    let(:mail) { ContactSharingMailer.share_contact(contact.id, email) }

    it 'renders the receiver email' do
      expect(mail.to).to eq([email])
    end

    it 'renders contact info' do
      expect(mail.body.encoded).to match(contact.first_name)
    end
  end
end
