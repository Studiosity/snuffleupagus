module Snuffleupagus
  #    Handles basic time-limited authentication token creation / validation
  #
  #    Uses Gibberish::AES with 256 bit CBC encryption
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
  #     snuffy.validate_token("53616c7465645f5f25dba4d4a97b238c4560ab46ffdfb77b28ad3e7121ab1917")
  #     #=> true
  #
  class AuthToken

    # tokens are only valid for 20 seconds
    MAX_VALID_TIME_DIFFERENCE = 20

    def initialize(key)
      @key = key
    end

    def create_token
      encode cipher.enc("#{constant}#{Time.now.to_i}", binary: true)
    end

    def check_token(token)
      return false unless token && token.is_a?(String)
      decoded = cipher.dec(decode(token), binary: true)
      match = /^#{constant}([0-9]+)$/.match decoded
      return false unless match
      (match[1].to_i - Time.now.to_i).abs < MAX_VALID_TIME_DIFFERENCE
    rescue
      false
    end

    private

    def cipher
      Gibberish::AES.new(@key, 256, 'cbc')
    end

    def constant
      'date:'
    end

    def encode(data)
      Digest.hexencode(data) if data
    end

    def decode(hexstring)
      hexstring.scan(/../).map { |n| n.to_i(16) }.pack('C*')
    end
  end
end
