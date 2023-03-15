On Vagrant:

A box is an operating system image.

`vagrant box add [USER/BOX]` allow us to download an image

For example:

`vagrant box add arodriguez/centos`

A project is a folder with a vagrant file (configuration file)

On this project we initialize the VM:

`vagrant init [USER/BOX]`

We turn it on with:

`vagrant up`

The VMs are started as headless mode (no GUI)

`vagrant up [VM_NAME]` or `vagrant up` that will turn on all VMs found on that file

`vagrant ssh [VM_NAME]` to ssh into the VMs. (Note: this will log with the user/pass vagrant and the root password will be vagrant too)

`vagrant halt [VM_NAME]` Stops the VMs

`vagrant suspend [VM]` Suspends the VM

`vagrant resume [VM]` Resumes the VM

`vagrant destroy [VM]` This terminates and deletes the VM

`vagrant` Will list options

The vagrant configurations (on its file) happen after the `vagrant.configure(version)` line and before the `end` line.

For example:

Note: the provision configuration, allows us to execute a script when the vm is open

```bash
Vagrant.configure(2) do | config|
	config.vm.box = "arodriguez/centos7"
	config.vm.hostname = "linuxsvr1"
	config.vm.network "private_network", ip: "10.2.3.4"
	config.vm.provision "shell", path:"setup.sh"

	end
```

If we wanted to specify settings for other VMs:

 ```bash
Vagrant.configure(2) do | config|
	config.vm.box = "arodriguez/centos7"
	
	config.vm.define "server1" do |server1|
	server1.vm.hostname= "server1"
	server1.vm.network "private_network", ip: "10.2.3.4"
	end
	
		config.vm.define "server1" do |server2|
	server2.vm.hostname= "server1"
	server2.vm.network "private_network", ip: "10.2.3.5"
	end

	end
```

Note: the vms share a common folder that's the project folder, which you can find in the `/vagrant` directory.