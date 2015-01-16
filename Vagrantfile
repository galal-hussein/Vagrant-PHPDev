# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "ubuntu/trusty64"

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 33306
  config.vm.network "private_network", ip: "10.0.33.11"


  config.vm.synced_folder "application/", "/var/www/app", create: true

   config.vm.provider "virtualbox" do |vb|
     vb.gui = false
     vb.memory = "1024"
   end

   config.vm.provision "shell", path: "provisioners/provision.sh"
  # config.vm.provision "ansible" do |ansible|
  #  ansible.playbook = "provisioners/playbook.yml"
  #  ansible.inventory_path = "provisioners/hosts"
  #  ansible.limit = "all"
  #end
end
