# pushover-ruby
- Ruby code utilizing the Pushover API for notifications anytime, anywhere!

## Instructions
This ruby script accepts 3 arguments: Title `ARGV[0]`, Message `ARGV[1]` and message weight [^1] `ARGV[2]`
[^1]: Refer to the Pushover API documentation here: https://pushover.net/api
```
#message info
title = ARGV[0]
message = ARGV[1]
...
#priorities: -2-lowest, -1-low, 0-norm, 1-high, 2-emg
weight = ARGV[2]
```
- You will need to add the Pushover application token and user key to the variables first:
```
Example:
token = "elkjmn4lkjfoijeelknlkh409elkj"
user = "lkfj48flkjsdf90w40dsflkjf"
```
- Then execute the script:
 `$ ruby push_template.rb "Greetings!" "Hello, GitHub!" "1"`

### Argument Error
If any of the three arguments are empy, the script will exit with error code 1. This is controlled by the following code (comment out to disable):
```
#check for ARGV and exit if empty
if ARGV[0].empty? || ARGV[1].empty? || ARGV[2].empty?
    puts "Requires at least three arguments: TITLE, MESSAGE, WEIGHT"
    exit(1)
end
```

## Emergency Weight
- When using the emergency weight (2), you also need to define two additional variables:
```
#for emergency priority
retries = "30"  # minimum requirement in seconds between notifications
expiration = "300" # time in seconds to continue the notification before expiring
```
- Then add those into the message:
```
#add additional parameters based on template creating
req.set_form_data({
    :token => "#{token}",
    :user => "#{user}",
    :title => "#{title}",
    :priority => "#{weight}",
    :message => "#{message}",
    :sound => "#{sound}",
    :device => "#{device}",
    :retry => "#{retries}",    #x#
    :expire => "#{expiration}" #x#
})
```
 
# Check Your Message Limits
 The ./lib/data directory contains a bash script that requests message limits from your account using cURL

`bash .lim` (renaming the script is recommended so you know what it is)
 
## opt directory
 Contains notification images that can be used as visuals (optional).

### Future Additions
- [ ] Add additional arguments for device, sound, etc.
- [ ] File attachment control (currently needs to be manually changed in the script)
- [ ] Automatic return of message limits in the main script (bash script removal)
