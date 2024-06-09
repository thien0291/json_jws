require "base64"
require "json"
require "jose"

module JsonJws::Verify
  def verify_signature(jwk, b64_payload, jws_json_signature)
    verify_hash = {
      "payload" => b64_payload,
      "protected" => jws_json_signature["protected"],
      "signature" => jws_json_signature["signature"],
    }

    JOSE::JWS.verify(jwk, verify_hash).first
  end

  def verify(jws, jwks)

    # verify payload is base64 encoded
    begin
      Base64.urlsafe_decode64(jws["payload"])
    rescue
      return false
    end

    jws["signatures"].each_with_index do |signature, index|
      return false unless verify_signature(jwks[index], jws["payload"], signature)
    end

    true
  end
end
