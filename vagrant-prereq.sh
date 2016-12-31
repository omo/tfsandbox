#!/bin/sh

vagrant plugin install vagrant-aws
vagrant box add aws-dummy https://github.com/mitchellh/vagrant-aws/raw/master/dummy.box
