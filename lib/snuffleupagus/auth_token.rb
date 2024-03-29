# frozen_string_literal: true

require 'openssl'

module Snuffleupagus
  # Handles basic time-limited authentication token creation / validation
  #
  # Uses OpenSSL AES with 256 bit CBC encryption
  #
  # ## Basic Usage
  #
  # ### Token creation
  #
  #     snuffy = Snuffleupagus::AuthToken.new('p4ssw0rd')
  #     snuffy.create_token
  #     #=> "53616c7465645f5f25dba4d4a97b238c4560ab46ffdfb77b28ad3e7121ab1917"
  #
  # ### Token validation
  #
  #     snuffy = Snuffleupagus::AuthToken.new('p4ssw0rd')
  #     snuffy.check_token("53616c7465645f5f25dba4d4a97b238c4560ab46ffdfb77b28ad3e7121ab1917")
  #     #=> true
  #
  class AuthToken
    def initialize(key)
      @key = key
      @cipher = OpenSSL::Cipher.new('aes-256-cbc')
    end

    def create_token(context:)
      encode encrypt "#{CONSTANT}#{context}#{Time.now.to_i}"
    end

    def token_valid?(token:, context:)
      return false unless token.is_a? String

      decoded = decrypt decode token
      match = /\A#{CONSTANT}#{Regexp.escape(context)}([0-9]+)\z/.match decoded
      return false unless match

      (match[1].to_i - Time.now.to_i).abs < MAX_VALID_TIME_DIFFERENCE
    rescue StandardError
      false
    end

    private

    CONSTANT = 'date:'
    MAX_VALID_TIME_DIFFERENCE = 120 # tokens are only valid for 2 minutes

    attr_reader :cipher

    def encrypt(data)
      salt = generate_salt
      setup_cipher(:encrypt, salt)
      e = cipher.update(data) + cipher.final
      "Salted__#{salt}#{e}" # OpenSSL compatible
    end

    def decrypt(data)
      raise ArgumentError, 'Data is too short' unless data.length >= 16

      salt = data[8..15]
      data = data[16..]
      setup_cipher(:decrypt, salt)
      cipher.update(data) + cipher.final
    end

    def setup_cipher(method, salt)
      cipher.send(method)
      cipher.pkcs5_keyivgen(@key, salt, 1)
    end

    def generate_salt
      Array.new(8) { rand(255).chr }.join
    end

    def encode(data)
      Digest.hexencode(data) if data
    end

    def decode(hexstring)
      hexstring.scan(/../).map { |n| n.to_i(16) }.pack('C*')
    end
  end
end
