Vagrant PHP Dev Box
===================

This setup will instruct Vagrant to install a php development stack on a ubuntu 14.04 VM.

The component of the dev stack:
* Ubuntu 14.04
* php5-fpm
* MySQL 5.5
* Nginx

## Installation

Install Vagrant from http://www.vagrantup.com/downloads.

## Use Ansible 

Ansible can be used for provisioning instead of the normal shell script, to use Ansible un-comment these lines in the Vagrantfile:
```
# config.vm.provision "ansible" do |ansible|
#   ansible.playbook = "provisioners/playbook.yml"
#   ansible.inventory_path = "provisioners/hosts"
#   ansible.limit = "all"
# end
```
and comment this line:
```
config.vm.provision "shell", path: "provisioners/provision.sh"
```

After that you should install ansible on your host, to install ansible on ubuntu:
```
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository ppa:ansible/ansible
$ sudo apt-get update
$ sudo apt-get install ansible
```
For more information on how to install ansible, read http://docs.ansible.com/intro_installation.html

## Vagrant Up 

Firing up a new machine is really simple:

```
# git clone https://github.com/galal-hussein/Vagrant-PHPDev.git
# cd vagrant-PHPDev
# vagrant up
```
