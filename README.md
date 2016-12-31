

# Tensorflow Sandbox VM Provisioner

This is my personal Vagrantfile for provisioning TensorFlow-ready VMs.
It is worth no more than personal dot files, so please don't take care of this thing.

## Prerequisite

 * Install 'vagrant' and optionally 'virtualbox'
 * Create `aws.json` file which has `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` as keys.
 * Run `./vagrant-prereq.sh`

# Setup EC2 instance

 * Create EC2 instance. This will provision required packages.
   * `> vagrant up --provider=aws`

## Using Jupyter

 * Establish SSH forwarding session: 
   * `> vagrant ssh -- -D 1080 -N -n &`
 * Configure web browser proxy using SOCKS5: `127.0.0.1:1089`, using proxy even for `localhost`.
 * Start jupyter notebook on the node, access it thourhg your browser.