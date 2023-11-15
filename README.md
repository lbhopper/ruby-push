# ruby-push ![Static Badge](https://img.shields.io/badge/Release-1.0.2-green)
Use the ruby programming language to handle your Pushover notifications

## Gem Requirements ![Static Badge](https://img.shields.io/badge/Ruby-Gems-red)
- net-http (default: 0.2.2)
- base64 (0.2.0, default: 0.1.1)
```
require 'net/http'
require 'yaml'
require 'base64'
```
## Usage
The script has ARGV[0] set by default for the message content. This is set by calling the script, then the argument:
- `ruby push.rb "argument goes here"`
## Config.yaml File
- Set default parameters to your notifications
- Easy configuration
- Expandable

## Emergency Priority
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
### Receipts
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
# Message Limits
Message limits are checked after each push with the following:
```
# Request message limits after push and add it to the responses.txt
res = Net::HTTP.new(limit_req.host, limit_req.port)
res.use_ssl = true
res.verify_mode = OpenSSL::SSL::VERIFY_PEER
response = res.start { |http| http.request(apps_limit) }
File.open(response_file, 'a') do |file|
    file.write(response.code, response.body)
    file.puts("\n" + '-' * 50 + "\n")
end
```
 
## opt directory
 Contains notification images that can be used as visuals (optional).
