#
require "net/https"
require "yaml"

#-Load the config.yaml
config = YAML.load_file('config.yaml')

#-Pushover API Data
url = URI.parse(config['push_api']['url'])
token = config['push_api']['robotics']
user = config['push_api']['user']
req = Net::HTTP::Post.new(url.path)

title = config['push']['title']
message = ARGV[0]
priority = config['push']['priority']
weight = priority[2]
sound_list = config['push']['sound']
sound = sound_list[5]
device = config['push']['device2']
timestamp = config['push']['timestamp']
html_flag = config['push']['html']
time_to_live = config['push']['ttl']
msg_url = config['push']['url']
url_title = config['push']['url_title']
attach_flag = config['attachment']['flag']
attach_file = config['attachment']['path']
attach_type = config['attachment']['type']
attach_b64 = config['attachment']['base64_flag']
max_size = config['attachment']['max_size']

#-required for emergency priority (optional otherwise)
retries = config['emergency']['retry']
expiration = config['emergency']['expire']

#############
#-Form Data-#
#############

req.set_form_data({
    :token => token,
    :user => user,
    :title => title,
    :priority => weight,
    :message => message,
    :sound => sound,
    :device => device
})

#-checks if attach_flag is 1 then checks file size before pushing
if attach_flag == 1
    if File.size(attach_file) < max_size
        res = Net::HTTP.new(url.host, url.port)
        res.use_ssl = true
        res.verify_mode = OpenSSL::SSL::VERIFY_PEER
        response = res.start { |http| http.request(req) }
        puts "#{response.code}"
    else
        puts "#{response.code}, #{response.body}"
    end
else
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = res.start { |http| http.request(req) }
    puts "#{response.code}"
end
