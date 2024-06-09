require "base64"
require "json"
require "jose"
require_relative "./sign"

module JsonJws::Encode
  def encode(jwk, header, payload)
    protected_header = Base64.urlsafe_encode64(header.to_json)
    payload = payload.to_json unless payload.is_a?(String)

    {
      "payload" => Base64.urlsafe_encode64(payload),
      "signatures" => [
        {
          "protected" => protected_header,
          "signature" => build_signature(jwk, header, payload),
        },
      ],
    }
  end
end
