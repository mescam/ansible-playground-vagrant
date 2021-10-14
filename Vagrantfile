# -*- mode: ruby -*-
# vi: set ft=ruby :

instances = [{:name => "node01", :ip => "192.168.10.3"},
             {:name => "node02", :ip => "192.168.10.4"},
             {:name => "node03", :ip => "192.168.10.5"}]

File.open("./hosts", 'w') { |file| 
  instances.each do |i|
    file.write("#{i[:ip]} #{i[:name]} #{i[:name]}\n")
  end
}

Vagrant.configure("2") do |config|
    config.vm.define "manager" do |i|
        i.vm.box = "hashicorp/bionic64"
        i.vm.hostname = "manager"
        i.vm.network "private_network", ip: "192.168.10.2"
        i.vm.provision "shell", path: "./provision-manager.sh"
    end

    instances.each do |instance|
        config.vm.define instance[:name] do |i|
            i.vm.box = "hashicorp/bionic64"
            i.vm.hostname = instance[:name]
            i.vm.network "private_network", ip: "#{instance[:ip]}"
            i.vm.provision "shell", path: "./provision.sh"
        end
    end
end
