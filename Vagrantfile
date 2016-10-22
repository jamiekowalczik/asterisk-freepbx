# -*- mode: ruby -*-
# vi: set ft=ruby :

ENV["VAGRANT_DETECTED_OS"] = ENV["VAGRANT_DETECTED_OS"].to_s + " cygwin"

Vagrant.configure(2) do |config|
  config.vm.box = "centos/7"
  config.vm.hostname = "asterisk"

  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # config.vm.network "private_network", ip: "192.168.33.10"

  config.vm.network "public_network", ip: "10.10.10.10"
  # , use_dhcp_assigned_default_route: true
  # , ip: "192.168.200.127"

  # config.vm.synced_folder "../data", "/vagrant_data"

  config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
     vb.name = "asterisk"
  end

   config.vm.provision "shell", path: "scripts/bootstrap.sh"
end
