# push.rb
Use the ruby programming language to handle your Pushover notifications

## Gem Requirements

![gems](https://github.com/BloodieToes/ruby-push/blob/main/gems.png?raw=true)

# Setup & Usage
### API Setup
- In order to take advantage of this ruby script, you must first set the application token and user key in the config.yaml file:

![api_data](https://github.com/BloodieToes/ruby-push/blob/main/api_data.png?raw=true)

### Usage
- The script has ARGV[0] set by default for the message content. This is handled by calling the script, then the argument:

![usage](https://github.com/BloodieToes/ruby-push/blob/main/usage.png?raw=true)

# Config.yaml File
- push.rb relies on the config.yaml file to pull in various parameters, which limits the amount of time spent inside the push.rb script
- Configure the yaml file with your application token, user key, device name(s), notification sound, etc.
- By default, the priority & sound dictionaries are set in the push.rb script:

![yaml_example1](https://github.com/BloodieToes/ruby-push/blob/main/yaml_example1.png?raw=true)

- Here, we can select which priority and sound to use (nested items have been marked with their corresponding numbers)

![config_snip](https://github.com/BloodieToes/ruby-push/blob/main/config_snip.png?raw=true)

## Attachments
- Need to attach an image? Set the image flag to 1, set your image directory path and the type. push.rb will check for the flag, then check the file size before pushing:

![attachments (1)](https://github.com/BloodieToes/ruby-push/blob/main/attachments.png?raw=true)

- then push.rb will encode the image to a Base64 encoding:

![b64](https://github.com/BloodieToes/ruby-push/blob/main/b64.png?raw=true)

# Emergency Priority
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
### Receipts
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
# Message Limits
Message limits are checked after each push with the following request:

![requests](https://github.com/BloodieToes/ruby-push/blob/main/requests.png?raw=true)
 
# opt directory

 Contains notification images that can be used as visuals (optional).

# Contributing
1. Fork the main branch
2. Switch to this branch: `git checkout dev`
3. Create your feature branch: `git checkout -b your-feature-name`
4. Commit your changes: `git commit -am 'your added feature'`
5. Push to the branch: `git push origin your-feature-name`
6. Create a new Pull Request against this repo
