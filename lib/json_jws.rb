# frozen_string_literal: true

require_relative "json_jws/version"
require_relative "json_jws/encode"
require_relative "json_jws/decode"
require_relative "json_jws/sign"
require_relative "json_jws/verify"

module JSON_JWS
  class Error < StandardError; end

  extend JsonJws::Encode
  extend JsonJws::Decode
  extend JsonJws::Sign
  extend JsonJws::Verify

  class << self
  end
end
