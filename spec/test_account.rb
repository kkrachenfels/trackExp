RSpec.describe Account, type: :model do
  subject {
    described_class.create(accountName: 'school stuff', id: 6)
  }

  describe 'validation' do
    it 'has valid attributes' do
      expect(subject.accountName).to eq('school stuff')
      expect(subject.id).to eq(6)
    end

    it 'does not have a user attached' do
      expect(subject.user_id).to eq(nil)
    end

    it 'has a user attached' do
      subject.user_id = 2
      expect(subject.user_id).to eq(2)
    end

    it 'can update balance' do
      expect(subject.balance).to eq(nil)
      subject.balance = 5
      expect(subject.balance).to eq(5)
    end

  end
end
