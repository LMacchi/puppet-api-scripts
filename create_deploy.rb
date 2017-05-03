#!/opt/puppetlabs/puppet/bin/ruby

require 'puppet'
require 'yaml'
require 'net/http'
require 'uri'
require 'json'

if ARGV.length != 1 then
  puts "USAGE:   #{$0} /path/to/data.json"
  exit 1 
end

Puppet.initialize_settings

certname = Puppet.settings[:certname]
hostcert = Puppet.settings[:hostcert]
hostprivkey = Puppet.settings[:hostprivkey]
localcert = Puppet.settings[:localcacert]
rbac_url = "https://#{certname}:4433/rbac-api/v1"
data = YAML.load_file(ARGV[0])

uri = URI("#{rbac_url}/users")

http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.cert = OpenSSL::X509::Certificate.new(File.read(hostcert))
http.key = OpenSSL::PKey::RSA.new(File.read(hostprivkey))
http.ca_file = localcert
http.verify_mode = OpenSSL::SSL::VERIFY_CLIENT_ONCE

request = Net::HTTP::Post.new(uri.request_uri)
request.body = data.to_json
request.content_type = 'application/json'

response = http.request(request)
code = response.code

if code == "303" then 
  puts "Request was successful"
  exit 0
else 
  msg = JSON.parse(response.body)["msg"]
  puts "Response #{code}: #{msg}"
  exit 1
end


