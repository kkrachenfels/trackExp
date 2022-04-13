RSpec.describe User, type: :model do
  subject {
    described_class.new(username: 'bob', password: 'ross', id: 5)
  }

  describe 'validation' do
    it 'has a username and password' do
      expect(subject.username).to eq('bob')
      expect(subject.password).to eq('ross')
      expect(subject.id).to eq(5)
    end

    it 'needs a password' do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it 'needs to fit minimum/maximum username and password constraints' do
      subject.username = 'b'
      expect(subject).to_not be_valid

      subject.username = 'asdjfklsajfksldjflksafjdlsafjdsklfjs'
      expect(subject).to_not be_valid
    end

    before {described_class.create!(username: 'bob', password: 'hello')}
    it 'has to use a unique username' do
      expect(subject).to be_invalid
    end

    it 'has a zero balance' do
      expect(subject.get_balance).to eq(0)
    end
  end
end
