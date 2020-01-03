Vagrant.configure("2") do |config|
  config.vm.box = "fedora/31-cloud-base"
  config.vm.box_version = "31.20191023.0"

  config.vm.provider :libvirt do |libvirt|
    libvirt.cpus = 2
    libvirt.memory = 2048
  end

  config.vm.provision "shell",
    privileged: false,
    path: "setup.sh"

end
