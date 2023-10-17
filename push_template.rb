require "net/https"

url = URI.parse("https://api.pushover.net/1/messages.json")
req = Net::HTTP::Post.new(url.path)
token = ""
user = ""

#message info
title = ARGV[0]
message = ARGV[1]
timestamp = Time.now
sound = "cosmic"

#priorities: -2-lowest, -1-low, 0-norm, 1-high, 2-emg
weight = [-2, -1, 0, 1, 2]

#attachment(s) - file size validation prior to push will occur
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

#add additional parameters based on template creating
req.set_form_data({
    :token => "#{token}",
    :user => "#{user}",
    :title => "#{title}",
    :priority => "#{weight[2]}",
    :message => "#{message}",
    :sound => "#{sound}"
})

#check for ARGV and exit if empty
if ARGV.empty?
    puts "Requires at least two arguments"
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