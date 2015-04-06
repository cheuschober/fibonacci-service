# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "ubuntu/trusty64"

  # Update memory / cpu settings
  config.vm.provider "virtualbox" do |vb|
      vb.memory = 1024
      vb.cpus = 2
  end

  # Is vagrant-cachier present?
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = true
  else
    puts "[-] WARN: You can save yourself time by running 'vagrant plugin install vagrant-cachier'"
  end

  # Manages the hostname for this vagrant install, important for salt clusters.
  config.vm.hostname = "salt"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network "forwarded_port", guest: 80, host: 8080

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Main application salt folders
  config.vm.synced_folder "salt/root", "/srv/salt/"
  config.vm.synced_folder "salt/pillar", "/srv/pillar"
  config.vm.synced_folder "salt/master.d", "/etc/salt/master.d"
  config.vm.synced_folder "salt/minion.d", "/etc/salt/minion.d"

  # Touch the custom pillar init file to ensure it doesn't complain
  config.vm.provision "shell", inline: "touch /srv/pillar/custom/init.sls"

  # Main vm provisioning via salt
  config.vm.provision :salt do |salt|
    salt.install_master = true
    install_type = "stable"
  end

  # accept the minion's key
  config.vm.provision "shell", inline: "salt-key -y -a " + config.vm.hostname

  config.vm.provisioners.each do |provisioner|
    if (provisioner.type == :salt and ENV.has_key?("SALT_FORMULAS_ROOT"))
      config.vm.synced_folder ENV["SALT_FORMULAS_ROOT"], "/srv/formulas"
      break
    end
  end

  # Run our salt highstate
  config.vm.provision :salt do |salt|
    salt.install_master = false
    salt.no_minion = true
    salt.run_highstate = true
    salt.verbose = true
  end
end
