Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.define "php-dev-box" do |config|
    config.vm.hostname = "php-dev-box"
    config.vm.network "private_network", ip: "192.168.33.250"
    # config.vm.network "forwarded_port", guest: 8080, host: 8080 # guest = VM, host = pc

    config.vm.provision "shell", path: "bootstrap.sh"

    config.ssh.insert_key = false
    config.ssh.username = "vagrant"
    config.ssh.password = "vagrant"

    config.vm.provider "virtualbox" do |v|
      v.cpus = 3
      v.memory = 3072
    end
  end
end
