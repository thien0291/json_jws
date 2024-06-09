# JsonJws

JsonJws is a Ruby gem that provides support for JWS (JSON Web Signature) with JSON serialization, specifically designed to handle multiple signatures.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'json_jws'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install json_jws

## Usage

```ruby
require "jose"
require "openssl"
require 'json_jws'

# If you want to load key from private key string
# rsa_key_01 = OpenSSL::PKey::RSA.new(rsa_priv_01_str)
# rsa_key_02 = OpenSSL::PKey::RSA.new(rsa_priv_01_str)

rsa_key_01 = OpenSSL::PKey::RSA.generate(2048)
puts "RSA key 01 Private: ", rsa_key_01.to_s, "\n"
puts "RSA key 01 Public: ", rsa_key_01.public_key.to_s
puts "\n" * 3

rsa_key_02 = OpenSSL::PKey::RSA.generate(2048)
puts "RSA key 02 Private: ", rsa_key_02.to_s, "\n"
puts "RSA key 02 Public: ", rsa_key_02.public_key.to_s
puts "\n" * 3

header = { "alg" => "RS256" }
payload = "It’s a dangerous business, Frodo, going out your door.".encode("utf-8")
payload = "{1}".encode("utf-8")
jwk = JOSE::JWK.from_key(rsa_key_01)
jwk2 = JOSE::JWK.from_key(rsa_key_02)

puts "\n\nEncoding:\n"
json_jws = JSON_JWS.encode(jwk, header, payload)
puts "json_jws: \n", json_jws

puts "\n\nVerify json jws"
verify_result = JSON_JWS.verify(json_jws, [jwk])
print "verify_result: ", verify_result

puts "\n\nAdd another signature"
json_jws_2 = JSON_JWS.add_signature(json_jws, jwk2, { "alg" => "RS256", "extra" => "field" })
# json_jws_2 = JSON_JWS.add_signature(json_jws, jwk2, header)
puts "json_jws_2: \n", json_jws_2

puts "\n\nVerify json jws 2"
verify_result = JSON_JWS.verify(json_jws_2, [jwk, jwk2])
print "verify_result: ", verify_result

puts "\n\nJWS multiple signatures decoding"
decoded = JSON_JWS.decode(json_jws_2)
print "decoded: ", decoded
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/json_jws. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/json_jws/blob/main/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the JsonJws project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/json_jws/blob/main/CODE_OF_CONDUCT.md).
