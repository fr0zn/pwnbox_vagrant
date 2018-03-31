# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.box = "geerlingguy/ubuntu1604"
  config.vm.provision "shell", path: "provision.sh", privileged: false
  config.vm.synced_folder ".", "/home/vagrant/files"
  config.vm.hostname = "pwnbox"

  config.vm.provider "virtualbox" do |v|
      v.name = "pwn"
      v.memory = 2048
      v.cpus = 2
    end
end
