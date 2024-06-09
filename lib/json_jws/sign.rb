require "base64"
require "json"
require "jose"

module JsonJws::Sign
  def build_signature(jwk, header, payload)
    payload = payload.to_json unless payload.is_a?(String)
    raise "header must be a Hash" unless header.is_a?(Hash)

    jose_signed_map = JOSE::JWS.sign(jwk, payload, header)
    jose_signed_map.to_hash.slice("protected", "signature").values
  end

  def add_signature(jws, jwk, protected_header)
    encoded_protected_header = Base64.urlsafe_encode64(protected_header.to_json)
    raw_payload = Base64.decode64(jws["payload"])
    protected_header, signature = build_signature(jwk, protected_header, raw_payload)

    jws["signatures"] << {
      "protected" => protected_header,
      "signature" => signature,
    }

    jws
  end
end
