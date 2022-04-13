RSpec.describe Transaction, type: :model do
  subject {
    described_class.create(name: 'groceries', tDate: '2022-04-12', tType: 0, amount: 45.50)
  }

  describe 'validation' do
    it 'has valid attributes' do
      expect(subject.name).to eq('groceries')
    end

    it 'does not have an account attached' do
      expect(subject.account_id).to eq(nil)
    end

    it 'has an account attached' do
      subject.account_id = 2
      expect(subject.account_id).to eq(2)
    end

    it 'is an expense' do
      expect(subject.get_type).to eq("Expense")
      expect(subject.get_signed_amount).to eq(-45.50)
    end

    it 'is an income' do
      subject.tType = 1
      expect(subject.get_type).to eq("Income")
      expect(subject.get_signed_amount).to eq(45.50)
    end
  end
end
