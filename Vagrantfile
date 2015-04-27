# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  $manifests_path = "puppet"
  $module_path = "puppet/modules"


  config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = $manifests_path
        puppet.manifest_file = "devel.pp"
        puppet.module_path = $module_path
  end

  config.vm.define "ubuntu" do |system|
        system.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
        system.ssh.forward_x11 = true
	system.ssh.insert_key = false
	system.vm.network "forwarded_port", guest: 5005, host: 5005, auto_correct: true
        system.vm.provision "puppet" do |puppet|
        	puppet.manifests_path = $manifests_path
        	puppet.manifest_file = "devel.pp"
       		puppet.module_path = $module_path
	end
  end

  config.vm.define "ubuntu32" do |system|
        system.vm.box = "puppetlabs/ubuntu-14.04-32-puppet"
        system.ssh.forward_x11 = true
	system.ssh.insert_key = false
  	system.vm.network "forwarded_port", guest: 5005, host: 5005, auto_correct: true
	system.vm.provision "puppet" do |puppet|
                puppet.manifests_path = $manifests_path
                puppet.manifest_file = "devel.pp"
                puppet.module_path = $module_path
        end
  end

end
