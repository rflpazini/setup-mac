# Setup my macOS

[Ansible](https://docs.ansible.com/ansible/latest/index.html) roles to setup my macOS and development environment

# Instructions

First, make sure you have `pip` installed. To install `pip` use the following command:

* `sudo easy_install pip`

Then install Ansible:

* `pip install ansible`

Now you should edit the `config.yml` to set your information and then you can just use `./run.sh` to execute Ansible. Remember to input your password when asked.

# Which applications will be installed??

* Alfred
* Caffeine
* Enpass
* Firefox
* iTerm2
* Karabiner-Elements
* Postman
* Slack
* Spotify
* Spectacle
* VSCode
* IntelliJIdea
* Minikube

# Which command line tools will be installed??

* docker
* docker-compose
* kubernetes-cli
* jq
* oh-my-zsh

Also, some functions, aliases and git configurations will be added as well.

* [.bash_profile](https://github.com/rflpazini/setup-mac/blob/master/roles/bash-profile/files/bash_profile)
* [macOS](https://github.com/rflpazini/setup-mac/blob/master/roles/osx-defaults/files/macos_defaults) defaults values changed

Some settings will only be applied after logging out.

> "Why program by hand in five days what you can spend five years of your life automating?"
> — Dr Terence Parr