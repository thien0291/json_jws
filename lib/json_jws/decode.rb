require "base64"
require "json"
require "jose"

module JsonJws::Decode
  def decode(jws, validate = true)
    signatures = jws["signatures"].map do |signature|
      {
        protected: JSON.load(Base64.urlsafe_decode64(signature["protected"])),
        signature: signature["signature"],
      }
    end

    {
      "payload" => Base64.urlsafe_decode64(jws["payload"]),
      "signatures" => signatures,
    }
  end
end
