#
require "net/https"
require "yaml"
require 'base64'

#-Load the config.yaml
config = YAML.load_file('config.yaml')

#-Pushover API Data
url = URI.parse(config['push_api']['url'])
limit_req = URI.parse(config['push_api']['limit_url'])
token = config['push_api']['app_token2']
user = config['push_api']['user']
req1 = Net::HTTP::Post.new(url.path)
req2 = Net::HTTP::Post.new(url.path)
apps_limit = Net::HTTP::Get.new(limit_req.path)

#-controlled by the config.yaml file
title = config['push']['title2']
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
attach_flag = config['image']['flag']
attach_file = config['image']['file_path']
attach_type = config['image']['type']
max_size = config['image']['max_size']
response_file = config['push']['res_file']

#-required for emergency priority (optional otherwise)
emg_flag = config['emergency']['flag']
retries = config['emergency']['retry']
expiration = config['emergency']['expire']
receipt = config['emergency']['receipt_file']

# Default request form data to be sent
req1.set_form_data({
    :token => token,
    :user => user,
    :title => title,
    :priority => weight,
    :message => message,
    :sound => sound,
    :device => device
})

# Request to check message limits on the current application
apps_limit.set_form_data({
    :token => token
})

#-checks if attach_flag is 1 then checks file size before pushing
if attach_flag == 1
    if File.size(attach_file) < max_size

        # set the Base64 variable
        b64_image_path = attach_file
        b64_data = File.read(b64_image_path)
        b64_encoded = Base64.encode64(b64_data)

        req2.set_form_data({
            :token => token,
            :user => user,
            :title => title,
            :priority => weight,
            :message => message,
            :sound => sound,
            :device => device,
            :attachment_base64 => b64_encoded,
            :attachment_type => attach_type
        })

        res = Net::HTTP.new(url.host, url.port)
        res.use_ssl = true
        res.verify_mode = OpenSSL::SSL::VERIFY_PEER
        response = res.start { |http| http.request(req2) }
        File.open(response_file, 'a') do |file|
            file.write(response.code, response.body)
            file.puts("\n" + '-' * 50 + "\n")
        end
    else
        puts "#{response.code}, #{response.body}"
    end
else
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = res.start { |http| http.request(req1) }
    File.open(response_file, 'a') do |file|
        file.write(response.code, response.body)
        file.puts("\n" + '-' * 50 + "\n")
    end
end

# Request message limits after push and add it to the responses.txt
res = Net::HTTP.new(limit_req.host, limit_req.port)
res.use_ssl = true
res.verify_mode = OpenSSL::SSL::VERIFY_PEER
response = res.start { |http| http.request(apps_limit) }
File.open(response_file, 'a') do |file|
    file.write(response.code, response.body)
    file.puts("\n" + '-' * 50 + "\n")
end