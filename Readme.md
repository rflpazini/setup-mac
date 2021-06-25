# Setup my macOS

[Ansible](https://docs.ansible.com/ansible/latest/index.html) roles to setup my macOS and development environment

# Instructions

First, make sure you have `pip` installed. To install `pip` use the following command:

```bash
$ sudo easy_install pip
```

Then install Ansible:

```bash
$ pip install ansible
```

Now you should edit the `config.yml` to set your information and then execute Ansible.

```bash
$ ./run.sh 
```
Remember to input your password when asked.

# Which applications will be installed??

* [caffeine](https://intelliscapesolutions.com/apps/caffeine)
* [enpass](https://www.enpass.io/)
* [firefox](https://www.mozilla.org/en-US/firefox/new/)
* [iTerm2](https://iterm2.com/)
* [insomnia](https://insomnia.rest/)
* [slack](https://slack.com/)
* [spotify](https://www.spotify.com/us/home/?correlation_id=50863fa17f244a62ecdb4d5c45ee838b&property_id=php_auth_home_deprecation)
* [spectacle](https://www.spectacleapp.com/)
* [vs-code](https://code.visualstudio.com/)
* [jetbrains-toolbox](https://www.jetbrains.com/toolbox-app/)
* [minikube](https://minikube.sigs.k8s.io/docs/start/)

# Which command line tools will be installed??

* docker
* docker-compose
* kubernetes-cli
* jq
* oh-my-zsh (with spaceship)
 

Also, some functions, aliases and git configurations will be added as well.

* [.bash_profile](https://github.com/rflpazini/setup-mac/blob/master/roles/bash-profile/files/bash_profile)
* [macOS](https://github.com/rflpazini/setup-mac/blob/master/roles/osx-defaults/files/macos_defaults) defaults values changed

Some settings will only be applied after logging out.

> "Why program by hand in five days what you can spend five years of your life automating?"
> — Dr Terence Parr
