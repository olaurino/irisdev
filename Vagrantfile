# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  $manifests_path = "puppet"
  $module_path = "puppet/modules"

  config.vm.box = "puppetlabs/ubuntu-14.04-64-puppet"
  config.ssh.forward_x11 = true
  config.ssh.insert_key = false

  config.vm.network "forwarded_port", guest: 5005, host: 5005, auto_correct: true

  config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = $manifests_path
        puppet.manifest_file = "devel.pp"
        puppet.module_path = $module_path
#        puppet.facter = {
#          "sherpa_checkout" => ENV['SHERPA_CHECKOUT']
#        }
  end

end
