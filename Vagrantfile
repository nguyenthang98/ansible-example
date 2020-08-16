NODE_COUNT_DEBIAN = 2
NODE_COUNT_REDHAT = 2
Vagrant.configure("2") do |config|

  config.trigger.before :up do |trigger|
    trigger.info = "Creating 'NATSwitch' Hyper-V switch if it does not exist..."
    trigger.run = {privileged: "true", powershell_elevated_interactive: "true", path: "./provision-scripts/nat-hyperv-switch.ps1"}
  end

  (1..NODE_COUNT_DEBIAN).each do |i|
	config.vm.define "ansible-node-#{i}" do |node|
  		node.vm.box = "generic/ubuntu1804"
		node.vm.hostname = "ansible-node-#{i}"
		node.vm.provider :hyperv do |hv, override|
			hv.memory = "1024"
			hv.cpus = "1"
			hv.mac = "00155E11221#{i}"
			hv.vmname = "ansible-node-#{i}"
		end
		node.vm.provision "shell" do |s|
			s.path = "./provision-scripts/configure-static-ip.sh"
			s.args = ["192.168.100.4#{i}"]
		end
		node.vm.provision :reload
		node.trigger.before :reload do |trigger|
		  	trigger.info = "Setting Hyper-V switch to 'NATSwitch' to allow for static IP..."

		  	trigger.run = {
				privileged: "true",
				powershell_elevated_interactive: "true", 
				path: "./provision-scripts/set-hyperv-switch.ps1",
				args: ["ansible-node-#{i}"]
			}
		end
	end
  end

   (1..NODE_COUNT_REDHAT).each do |i|
 	config.vm.define "ansible-node-#{NODE_COUNT_DEBIAN+i}" do |node|
   		node.vm.box = "generic/centos7"
 		node.vm.hostname = "ansible-node-#{NODE_COUNT_DEBIAN+i}"
 		node.vm.provider :hyperv do |hv, override|
 			hv.memory = "1024"
 			hv.cpus = "1"
 			hv.mac = "00155E11221#{NODE_COUNT_DEBIAN+i}"
 			hv.vmname = "ansible-node-#{NODE_COUNT_DEBIAN+i}"
 		end
 		node.vm.provision "shell" do |s|
 			s.path = "./provision-scripts/configure-static-ip-centos.sh"
 			s.args = ["192.168.100.4#{NODE_COUNT_DEBIAN+i}"]
 		end
 		node.vm.provision :reload
 		node.trigger.before :reload do |trigger|
 		  	trigger.info = "Setting Hyper-V switch to 'NATSwitch' to allow for static IP..."
 
 		  	trigger.run = {
 				privileged: "true",
 				powershell_elevated_interactive: "true", 
 				path: "./provision-scripts/set-hyperv-switch.ps1",
 				args: ["ansible-node-#{NODE_COUNT_DEBIAN+i}"]
 			}
 		end
 	end
   end
end
