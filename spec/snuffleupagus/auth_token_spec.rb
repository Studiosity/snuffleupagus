# frozen_string_literal: true

require './lib/snuffleupagus'
require 'timecop'

describe Snuffleupagus::AuthToken do
  let(:snuffy) { described_class.new('sup3r4w3s0m3p4ssw0rd') }

  describe '#create_token' do
    subject(:create_token) { snuffy.create_token context: 'my-context' }

    it { is_expected.to be_a String }
    it { expect(create_token.length).to eq 96 }
    it { is_expected.to match(/\A[a-f0-9]{96}\z/) }
  end

  describe '#token_valid?' do
    subject(:token_valid?) { snuffy.token_valid?(token: token, context: 'my-context') }

    context 'with a valid token' do
      let(:token) { snuffy.create_token context: 'my-context' }

      it { is_expected.to be_truthy }
    end

    context 'when the context doesnt match' do
      let(:token) { snuffy.create_token context: 'another-context' }

      it { is_expected.to be_falsey }
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

    context 'with an expired token' do
      let(:token) { snuffy.create_token context: 'my-context' }

      before { token } # pre-load the token
      after { Timecop.return }

      context 'when just inside the time difference (expired token)' do
        before { Timecop.freeze Time.now - 119 }

        it { is_expected.to be_truthy }
      end

      context 'when just outside the time difference (expired token)' do
        before { Timecop.freeze Time.now - 120 }

        it { is_expected.to be_falsey }
      end

      context 'when just inside the time difference (future token)' do
        before { Timecop.freeze Time.now + 119 }

        it { is_expected.to be_truthy }
      end

      context 'when just outside the time difference (future token)' do
        before { Timecop.freeze Time.now + 120 }

        it { is_expected.to be_falsey }
      end
    end
  end
end
