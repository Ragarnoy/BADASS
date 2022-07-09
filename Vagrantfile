def gui_enabled?
    !ENV.fetch('GUI', '').empty?
end

Vagrant.configure("2") do |config|
    config.vm.box = "ubuntu/jammy64"
    config.vm.hostname = "badass"

    config.vm.provider "virtualbox" do |vb|
        vb.name = "badass-project"
        vb.memory = 8192
        vb.cpus = 3
        vb.gui = gui_enabled?
    end

    config.vm.provision "shell",
        run: "once",
        path: "starter/init_vm_install.sh"

    config.vm.provision "ansible_local" do |ansible|
        ansible.install = false
        ansible.playbook = "starter/playbook/init.yml"
    end
end
