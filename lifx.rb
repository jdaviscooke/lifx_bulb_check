require 'rest-client'

key = ENV['LIFX_KEY'] || File.read('secrets/key')


response = RestClient.get "https://api.lifx.com/v1beta1/lights/all", {:Authorization => "Bearer #{key}"}

json = JSON.parse(response)

failed = false

json.each do |light|
  if !light['connected']
    print "CRITICAL"
    failed = true
  else
    print "OK"
  end
  puts " - #{light['label']} (#{light['id']}): Connected = #{light['connected']}; Last seen: #{light['last_seen']}"
end
exit 2 if failed
