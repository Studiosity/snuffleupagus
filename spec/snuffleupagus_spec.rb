require './lib/snuffleupagus'

describe Snuffleupagus::AuthToken do
  let(:snuffy) { Snuffleupagus::AuthToken.new('sup3r4w3s0m3p4ssw0rd') }

  describe '#create_token' do
    subject { snuffy.create_token }

    it 'creates an encrypted token' do
      is_expected.to be_a String
      expect(subject.length).to eq 64
    end
  end

  describe '#check_token' do
    subject { snuffy.check_token(token) }

    context 'with a valid token' do
      let(:token) { snuffy.create_token }

      it 'returns true' do
        is_expected.to be_truthy
      end
    end

    [ ['with an invalid token', 'F00B44'],
      ['with an empty token', ''],
      ['with a nil token']
    ].each do |context, token|
      let(:token) { token }

      context context do
        it 'returns false' do
          is_expected.to be_falsey
        end
      end
    end
  end
end
