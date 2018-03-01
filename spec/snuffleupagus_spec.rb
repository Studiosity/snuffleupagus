require './lib/snuffleupagus'
require 'timecop'

describe Snuffleupagus::AuthToken do
  let(:snuffy) { Snuffleupagus::AuthToken.new('sup3r4w3s0m3p4ssw0rd') }

  describe '#create_token' do
    subject { snuffy.create_token }

    it { is_expected.to be_a String }
    it { expect(subject.length).to eq 64 }
    it { is_expected.to match(/\A[a-f0-9]{64}\z/) }
  end

  describe '#check_token' do
    subject { snuffy.check_token(token) }

    context 'with a valid token' do
      let(:token) { snuffy.create_token }
      it { is_expected.to be_truthy }
    end

    context 'with an invalid token' do
      let(:token) { 'F00B44' }
      it { is_expected.to be_falsey }
    end

    context 'with an empty token' do
      let(:token) { '' }
      it { is_expected.to be_falsey }
    end

    context 'with a nil token' do
      let(:token) { nil }
      it { is_expected.to be_falsey }
    end

    context 'testing expired tokens' do
      let(:token) { snuffy.create_token }
      before { token } # pre-load the token
      after { Timecop.return }

      context 'just inside the time difference (expired token)' do
        before { Timecop.freeze Time.now - 119 }
        it { is_expected.to be_truthy }
      end

      context 'just outside the time difference (expired token)' do
        before { Timecop.freeze Time.now - 120 }
        it { is_expected.to be_falsey }
      end

      context 'just inside the time difference (future token)' do
        before { Timecop.freeze Time.now + 119 }
        it { is_expected.to be_truthy }
      end

      context 'just outside the time difference (future token)' do
        before { Timecop.freeze Time.now + 120 }
        it { is_expected.to be_falsey }
      end
    end
  end
end
