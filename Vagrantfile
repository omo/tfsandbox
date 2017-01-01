# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'vagrant-aws'
require 'json'

# Pick what works for you
AWS_SECRETS_PATH = 'aws.json'
AWS_SSH_KEY_PATH = '~/.ssh/uswest2key.pem'
AWS_SSH_KEYPAIR  = 'uswest2key'
AWS_REGION = 'us-west-2'
EC2_INSTANCE_TYPE = 'g2.2xlarge'
EC2_BD_MAPPINGS = [{ 'DeviceName' => '/dev/sda1', 'Ebs.VolumeSize' => 50 }, { 'DeviceName' => '/dev/sdb', 'VirtualName' => 'ephemeral0' }]

Vagrant.configure("2") do |config|
  if File.exists?(AWS_SECRETS_PATH)
    secrets = JSON.load(open(AWS_SECRETS_PATH))
    config.vm.provider 'aws' do |aws, override|
      aws.access_key_id = secrets['AWS_ACCESS_KEY_ID']
      aws.secret_access_key = secrets['AWS_SECRET_ACCESS_KEY']
      aws.keypair_name = AWS_SSH_KEYPAIR
      aws.region = AWS_REGION
      # Ubuntu 16.10. See https://cloud-images.ubuntu.com/locator/ec2/
      aws.ami = 'ami-55ff4a35'
      aws.instance_type = EC2_INSTANCE_TYPE
      aws.block_device_mapping = EC2_BD_MAPPINGS
      aws.security_groups = ['default']

      override.ssh.username = 'ubuntu'
      override.ssh.private_key_path = AWS_SSH_KEY_PATH
      override.vm.box = "aws-dummy"
    end
  end

  config.vm.provider "virtualbox" do |vb, override|
    override.vm.box = "bento/ubuntu-16.10"
  end

  config.vm.provision :shell, name: "root", privileged: true, inline: <<-SHELL
    apt-get update
    apt-get install linux-headers-$(uname -r)
    apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev xz-utils
    apt-get install -y nvidia-cuda-toolkit
  
    if [ ! -f /usr/local/cuda/include/cudnn.h ]; then
      # See https://github.com/NVIDIA/nvidia-docker/ for update to the latest.
      curl -fsSL http://developer.download.nvidia.com/compute/redist/cudnn/v5.1/cudnn-8.0-linux-x64-v5.1.tgz -O
      tar -xzf cudnn-8.0-linux-x64-v5.1.tgz -C /usr/local
      rm cudnn-8.0-linux-x64-v5.1.tgz
    fi
  SHELL

  config.vm.provision :shell, name: "python", privileged: false, inline: <<-SHELL
    if [ ! -d ~/.pyenv ]; then
      curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash
      export PATH="$HOME/.pyenv/bin:$PATH"
      eval "$(pyenv init -)"
      eval "$(pyenv virtualenv-init -)"
      pyenv install 3.5.2
      pyenv global 3.5.2
    fi
  SHELL

  config.vm.provision :file, source: "bash_profile", destination: "~/.bash_profile"

  config.vm.provision :shell, name: "pip", privileged: false, inline: <<-SHELL
    pip install --upgrade pip
    pip install tensorflow-gpu sklearn matplotlib pandas scipy jupyter Keras Pillow
  SHELL
end
