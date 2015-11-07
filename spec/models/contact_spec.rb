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

  describe '#name' do
    it { expect(subject.name).to eq("#{subject.first_name} #{subject.last_name}") }
  end

  [:phones, :emails].each do |method|
    describe "##{method}=" do
      it 'convert string to array' do
        expect { subject.send("#{method}=", '123;abc') }.to change { subject.send(method) }.to(%w(123 abc))
      end
      it 'rejects blank fields' do
        expect { subject.send("#{method}=", ['123', '', 'abc']) }.to change { subject.send(method) }.to(%w(123 abc))
      end
    end
  end
end
