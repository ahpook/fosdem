Fosdem Puppet Intro
-------------------

This is a 'rosetta stone' type of demo about configuration management.  We're going to show the same tasks implemented in three different tools: Puppet, Chef and Cfengine.

I'm eric sorenson, I'm open source product guy at puppet labs, and as such I'm going to talk about puppet. 

Let me start off with some building blocks -- everything in puppet is a resource. 
- a file whose contents you want to manage,
- service that should be running or needs to be removed from startup,
- all the way up to a database that needs to get created

Puppet has its own Domain-Specific Language for describing resources. 

```puppet

user { 'vagrant':
  ensure           => 'present',
  comment          => 'vagrant,,,',
  gid              => '1000',
  groups           => ['adm', 'cdrom', 'sudo', 'dip', 'plugdev', 'lpadmin', 'sambashare'],
  home             => '/home/vagrant',
  password         => '$6$We/Gafx4$jbremGBkrVu0XvF1aCHWahit31Y2juEzyy0rImgTEC3xXZb9J58MFJPn4biiOx1rpqQJ8fOs5trN2rm8vuIaU1',
  password_max_age => '99999',
  password_min_age => '0',
  shell            => '/bin/bash',
  uid              => '1000',
}

```

Since puppet models everything as a resource, it enables lots of neat things like dependency management in the form of a graph and round-trips of resources that can be repeatable, idempotent, and cross platform.

So I can for instance take that user, edit its shell and save it back out to make the changes live -- or even pipe it over the network.

```shell
vagrant@webnode:~$ sudo puppet resource --edit user vagrant
Info: Applying configuration version '1359771023'
Notice: /Stage[main]//User[vagrant]/shell: shell changed '/bin/bash' to '/bin/zsh'
Notice: Finished catalog run in 0.11 seconds
```

But the usual way to run puppet is not as one off resource edits, but to describe whatever state you want the resources across your network to look like and store it in a series of MANIFESTS organized into logical groups of related resources called MODULES on a server. Agents periodically check in and get the latest version of their CATALOG, then compare their local state to the description defined in the catalog, make any changes to bring themselves into line, then upload a REPORT saying what they've done.

The original idea for the wizz-bang part of the demo was to do AWS nodes with a multi-node wordpress installation. I didn't trust the network here so I'm running boxes locally via Vagrant. But this is how it would work, using puppetlabs cloud_provisioner:

	[eric@glitch.local ~]% puppet node_aws create --image ami-013f9768 --keyname eric0-aws-key --security_group puppet-outbound --type m1.small --credentials default --trace
	Notice: Creating new instance ...
	Notice: Creating new instance ... Done
	Notice: Creating tags for instance ... 
	Notice: Creating tags for instance ... Done
	Notice: Launching server i-8a038efa ...
	###################################
	Notice: Server i-8a038efa is now launched
	Notice: Server i-8a038efa public dns name: ec2-54-234-137-18.compute-1.amazonaws.com
	ec2-54-234-137-18.compute-1.amazonaws.com

Here's what I did instead, using vagrant, also w/ puppet!

This is a minimal vagrant setup that uses the built-in puppet provisioning.

* host: show Vagrantfile w/ box setup and puppet provisioner

The provision part is Vagrant's equivalent of a post-kickstart script; it runs after the box is running but before it's really "ready to rock". So it's a perfect place to do some simple post-install configuration, just enough to run puppet for REAL and get the box's PERSONALITY in place.

* host: show vagrant-manifests/site.pp with hosts declaration
* host: vagrant up webnode dbnode

So now the hosts are running, what's next? We need to point them at the master to configure them -- usually this is done as a post-provisioning step.

Went out onto the forge and found some good modules, built up a little site config for them.

* host: puppet module list --confdir /Sandbox/fosdem/puppet/
* host: show manifests/site.pp

There are two node definitions here, one for the host named webnode and one for the dbnode. The things that are common to both of them I've put in a little module called, surprinsgly enough, 'common'. Then the host-specific stuff follows in the node definition.

* host: show common

Now I'm going to login and fire off a puppet run to both of these guys. I want to show the steps they'd go through to bring themselves up to working; obviously if you're doing this at scale you would just go ahead and run puppet automatically either in a full run after your provisioning step, or upon first reboot.

* host: vagrant ssh dbnode
* dbnode: sudo puppet agent -t

OK, brought up the database, you can see in the log output that Puppet connected, automatically got some plugins that extend its capabilities, got its CATALOG like I said, and started checking things on the local system to see what was missing or wrong. It ended up installing packages, editing some files, starting up the service, which we can see is running correctly and has a database grant for the other machine.

* dbnode: netstat -an | grep LISTEN
* dbnode: mysql -u root -p
* dbnode: show databases;

Now let's repeat it on the web node, which as you can see isn't up yet


* host: browser : http://webnode.local/
* host: vagrant ssh webnode
* webnode: sudo puppet agent -t

Tons of stuff got installed there, according to the ordering and dependency chain in the model. Now we should be able to go to the root of the site and set up wordpress:

* host: browser reload on http://webnode.local/
* host: go through install guide.