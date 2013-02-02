# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.
  ubuntu_box = "http://puppetlabs.s3.amazonaws.com/pub/vagrant/ubuntu-server-1204-x64.box"
 
  # per-VM configuration goes here
  config.vm.define :webnode do |webnode_config|
    webnode_config.vm.box = 'ubuntu-server-1204-x64'
    webnode_config.vm.box_url = ubuntu_box
    webnode_config.vm.network :hostonly, "192.168.23.20"

    webnode_config.vm.boot_mode = :gui
    webnode_config.vm.host_name = "webnode.local"
    webnode_config.vm.provision :puppet do |webnode_puppet|
      webnode_puppet.pp_path = "/tmp/vagrant-puppet"
      webnode_puppet.manifests_path = "vagrant_manifests"
      webnode_puppet.manifest_file = "site.pp"
      webnode_puppet.module_path = "puppet/modules"

    end
  end

  config.vm.define :dbnode do |dbnode_config|
    dbnode_config.vm.box = 'ubuntu-server-1204-x64'
    dbnode_config.vm.box_url = ubuntu_box
    dbnode_config.vm.network :hostonly, "192.168.23.21"

    dbnode_config.vm.boot_mode = :gui
    dbnode_config.vm.host_name = "dbnode.local"
    dbnode_config.vm.provision :puppet do |dbnode_puppet|
      dbnode_puppet.pp_path = "/tmp/vagrant-puppet"
      dbnode_puppet.manifests_path = "vagrant_manifests"
      dbnode_puppet.manifest_file = "site.pp"
      dbnode_puppet.module_path = "puppet/modules"
    end
  end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Boot with a GUI so you can see the screen. (Default is headless)
  #config.vm.boot_mode = :gui

  # Assign this VM to a host-only network IP, allowing you to access it
  # via the IP. Host-only networks can talk to the host machine as well as
  # any other machines on the same network, but cannot be accessed (through this
  # network interface) by any external networks.
  # -- networking is broken out per-vm
  # config.vm.network :hostonly, "192.168.23.10"
   

  # Assign this VM to a bridged network, allowing you to connect directly to a
  # network using the host's network device. This makes the VM appear as another
  # physical device on your network.
  # config.vm.network :bridged

  # Forward a port from the guest to the host, which allows for outside
  # computers to access the VM, whereas host only networking does not.
  # config.vm.forward_port 80, 8080

  # Share an additional folder to the guest VM. The first argument is
  # an identifier, the second is the path on the guest to mount the
  # folder, and the third is the path on the host to the actual folder.
  #config.vm.share_folder "Sandbox", "/Sandbox", "/Users/eric/Sandbox", :nfs => true

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "base.pp"
  # end

  # Enable provisioning with chef solo, specifying a cookbooks path, roles
  # path, and data_bags path (all relative to this Vagrantfile), and adding 
  # some recipes and/or roles.
  #
  # config.vm.provision :chef_solo do |chef|
  #   chef.cookbooks_path = "../my-recipes/cookbooks"
  #   chef.roles_path = "../my-recipes/roles"
  #   chef.data_bags_path = "../my-recipes/data_bags"
  #   chef.add_recipe "mysql"
  #   chef.add_role "web"
  #
  #   # You may also specify custom JSON attributes:
  #   chef.json = { :mysql_password => "foo" }
  # end

  # Enable provisioning with chef server, specifying the chef server URL,
  # and the path to the validation key (relative to this Vagrantfile).
  #
  # The Opscode Platform uses HTTPS. Substitute your organization for
  # ORGNAME in the URL and validation key.
  #
  # If you have your own Chef Server, use the appropriate URL, which may be
  # HTTP instead of HTTPS depending on your configuration. Also change the
  # validation key to validation.pem.
  #
  # config.vm.provision :chef_client do |chef|
  #   chef.chef_server_url = "https://api.opscode.com/organizations/ORGNAME"
  #   chef.validation_key_path = "ORGNAME-validator.pem"
  # end
  #
  # If you're using the Opscode platform, your validator client is
  # ORGNAME-validator, replacing ORGNAME with your organization name.
  #
  # IF you have your own Chef Server, the default validation client name is
  # chef-validator, unless you changed the configuration.
  #
  #   chef.validation_client_name = "ORGNAME-validator"
end
