describe Contact, type: :model do
  subject { create(:contact) }

  it { is_expected.to be_valid }
  it { is_expected.to validate_presence_of :first_name }
  it { is_expected.to validate_presence_of :last_name }
  it { is_expected.to validate_presence_of :emails }
  it { is_expected.to validate_presence_of :phones }
  it { is_expected.to validate_uniqueness_of(:first_name).scoped_to(:last_name) }

  describe 'validations' do
    context 'without phones, with emails' do
      subject { build(:contact, phones: nil) }
      it { is_expected.to be_valid }
    end
    context 'with phones, without emails' do
      subject { build(:contact, emails: nil) }
      it { is_expected.to be_valid }
    end
    context 'without phones, without emaisl' do
      subject { build(:contact, emails: nil, phones: nil) }
      it { is_expected.to_not be_valid }
    end
  end

end
