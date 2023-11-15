# push.rb
Use the ruby programming language to handle your Pushover notifications

## Gem Requirements

![gems](https://github.com/BloodieToes/ruby-push/assets/116280844/e3881038-941c-44ca-bec2-76d2c73276c6)

# Setup & Usage
### API Setup
- In order to take advantage of this ruby script, you must first set the application token and user key in the config.yaml file:

![api_data](https://github.com/BloodieToes/ruby-push/assets/116280844/78b57621-17d8-41e7-b495-29289cc6d6ca)

### Usage
- The script has ARGV[0] set by default for the message content. This is handled by calling the script, then the argument:

![usage](https://github.com/BloodieToes/ruby-push/assets/116280844/35b53cc3-7967-44c3-aece-5fd6b44e9824)

# Config.yaml File
- push.rb relies on the config.yaml file to pull in various parameters, which limits the amount of time spent inside the push.rb script
- Configure the yaml file with your application token, user key, device name(s), notification sound, etc.
- By default, the priority & sound dictionaries are set in the push.rb script:

![yaml_example1](https://github.com/BloodieToes/ruby-push/assets/116280844/b4b50eda-1a0a-4e4f-a035-59c38506581b)

- Here, we can select which priority and sound to use (nested items have been marked with their corresponding numbers)

![config_snip](https://github.com/BloodieToes/ruby-push/assets/116280844/ed325031-07dd-47fd-aa43-f061839adf1a)

## Attachments
- Need to attach an image? Set the image flag to 1, set your image directory path and the type. push.rb will check for the flag, then check the file size before pushing:

![attachments (1)](https://github.com/BloodieToes/ruby-push/assets/116280844/4e92ed51-540d-4f98-a383-43fe3ca1128e)

- then push.rb will encode the image to a Base64 encoding:

![b64](https://github.com/BloodieToes/ruby-push/assets/116280844/06566007-a11b-44e3-826f-0ecd61c1b425)

# Emergency Priority
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
### Receipts
- ![Static Badge](https://img.shields.io/badge/STATUS-WIP-yellow)
# Message Limits
Message limits are checked after each push with the following request:

![requests](https://github.com/BloodieToes/ruby-push/assets/116280844/8ba7cd9d-b6c9-467a-a4fe-06818bcc0d4b)
 
# opt directory
 Contains notification images that can be used as visuals (optional).
