# Usage:
# ruby push_template.rb "Title" "Message" "Weight"
#
require "net/https"

url = URI.parse("https://api.pushover.net/1/messages.json")
req = Net::HTTP::Post.new(url.path)
token = ""
user = ""

#message variables

#-required
title = ARGV[0]
message = ARGV[1]

#optional
timestamp = Time.now
sound = "cosmic"
device = ""

#priorities: -2-lowest, -1-low, 0-norm, 1-high, 2-emg
weight = ARGV[2]

#attachment(s) - file size validation will occur if the attach_flag is set to 1
attach_flag = 0
attach_file = '/path/to/file'
max_size = 2621440

#for emergency priority
retries = ""
expiration = ""

#add journal message - this will write to the syslog when triggered
syslog1 = "Push - SUCCESS"
syslog2 = "Push - FAILED"
syslog3 = "RESERVED"
syslog4 = "RESERVED"
syslog5 = "Push - File Size Error: Exceeds #{max_size}"

#add optional variables here
req.set_form_data({
    :token => "#{token}",
    :user => "#{user}",
    :title => "#{title}",
    :priority => "#{weight}",
    :message => "#{message}",
    :sound => "#{sound}",
    :device => "#{device}"
})

#check for ARGV and exit if empty
if ARGV[0].empty? || ARGV[1].empty? || ARGV[2].empty?
    puts "Requires at least three arguments: TITLE, MESSAGE, WEIGHT"
    exit(1)
end

#checks if attach_flag is 1 then checks file size before pushing
if attach_flag == 1
    if File.size(attach_file) < max_size
        res = Net::HTTP.new(url.host, url.port)
        res.use_ssl = true
        res.verify_mode = OpenSSL::SSL::VERIFY_PEER
        res.start { |http| http.request(req) }
        system("logger '#{syslog1}'")
    else
        system("logger '#{syslog5}'")
    end
else
    res = Net::HTTP.new(url.host, url.port)
    res.use_ssl = true
    res.verify_mode = OpenSSL::SSL::VERIFY_PEER
    res.start { |http| http.request(req) }
    system("logger '#{syslog1}'")
end
