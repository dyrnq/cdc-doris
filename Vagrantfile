# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    config.vm.disk :disk, size: "500GB", primary: true
    # config.vm.box_version = "20221121.0.0"

    config.vm.box_check_update = false
    config.ssh.insert_key = false
    # insecure_private_key download from https://github.com/hashicorp/vagrant/blob/master/keys/vagrant
    config.ssh.private_key_path = "insecure_private_key"




    cdc_machines = {
        'cdc'   => '192.168.56.200',
    }

    cdc_machines.each do |name, ip|
        config.vm.define name do |machine|
            machine.vm.network "private_network", ip: ip

            machine.vm.hostname = name
            machine.vm.provider :virtualbox do |vb|
                vb.name = name  
                vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
                vb.customize ["modifyvm", :id, "--vram", "32"]
                vb.customize ["modifyvm", :id, "--ioapic", "on"]
                vb.customize ["modifyvm", :id, "--cpus", "4"]
                vb.customize ["modifyvm", :id, "--memory", "16384"]
            end

            machine.vm.provision "shell", path: "scripts/provision.sh"


        end
    end



end