Vagrant.configure('2') do |config|
  config.vm.box = 'azure'

  config.vm.synced_folder ".", "/vagrant", type: "rsync", disabled: true

  # use local ssh key to connect to remote vagrant box
  config.ssh.private_key_path = '~/.ssh/id_rsa'
  config.vm.provider :azure do |azure, override|

    # each of the below values will default to use the env vars named as below if not specified explicitly
    azure.tenant_id = ENV['AZURE_TENANT_ID']
    azure.client_id = ENV['AZURE_CLIENT_ID']
    azure.client_secret = ENV['AZURE_CLIENT_SECRET']
    azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']
    azure.location = "germanywestcentral"
    azure.vm_size = "Standard_B2s"
    azure.resource_group_name = "devops-minitwit"
    azure.vm_name = "minitwitb"
    azure.dns_name = "minitwitb"
    azure.tcp_endpoints = [3000, 9000, 8080]
  end


  config.vm.provision :docker
  config.vm.provision :file, source:".secrets/azure_rsa.pub", destination:"~/.ssh/azure_rsa.pub"
  config.vm.provision :shell, inline: "cat ~vagrant/.ssh/azure_rsa.pub >> ~vagrant/.ssh/authorized_keys"
  # config.vm.provision :shell, path: "bootstrap.sh", run: "always"
  config.vm.provision :file, source:"docker-compose.yml", destination:"/deployment/docker-compose.yml", run: "always"
  config.vm.provision :docker_compose, yml: "/deployment/docker-compose.yml", compose_version: "v2.2.3", rebuild: true, run: "always"
end