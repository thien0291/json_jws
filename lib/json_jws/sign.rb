require "base64"
require "json"
require "jose"

module JsonJws::Sign
  def build_signature(jwk, header, payload)
    payload = payload.to_json unless payload.is_a?(String)
    raise "header must be a Hash" unless header.is_a?(Hash)

    encoded_payload = Base64.urlsafe_encode64(payload)
    encoded_header = Base64.urlsafe_encode64(header.to_json)

    JOSE::JWS.sign(jwk, payload, header).to_hash["signature"]
  end

  def add_signature(jws, jwk, header, payload)
    protected_header = Base64.urlsafe_encode64(header.to_json)
    payload = payload.to_json unless payload.is_a?(String)

    jws["signatures"] << {
      "protected" => protected_header,
      "signature" => build_signature(jwk, header, payload),
    }

    jws
  end
end
