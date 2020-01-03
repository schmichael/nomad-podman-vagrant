# Nomad Podman Testing

Vagrantfile to setup a VM with Nomad + Podman for testing the [Nomad Podman
Driver](https://github.com/pascomnet/nomad-driver-podman).

## Prereqs

* Vagrant: https://www.vagrantup.com/
* Only tested with the libvirt provider on Linux: https://github.com/vagrant-libvirt/vagrant-libvirt

## Test Nomad+Podman

```
# Create box
vagrant up

# Run Nomad
vagrant ssh
nomad agent -config /vagrant/client.hcl

# In another terminal
vagrant ssh
nomad run /vagrant/example.nomad

# Connect to redis
nomad status alloc-id-from-run
nc ip-from-above port-from-above
ping
# should see +PONG
quit
# should see +OK
^D
```

## Notes

* `setup.sh` does all of the ugly system configuration
* The reboot at the end of the setup script is kind of janky `¯\_(ツ)_/¯`
* Only tested using a Fedora box
* `podman ps` doesn't seem to list Nomad tasks
* Is this root-less? Nomad doesn't require root, but podman+conmon seem to run
  as root...
