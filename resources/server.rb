# Cookbook Name:: nomad
#
# Resource:: server
#

actions :add, :remove
default_action :add

attribute :user, :kind_of => String, :default => "nomad"
attribute :group, :kind_of => String, :default => "nomad"
attribute :log_dir, :kind_of => String, :default => "/var/log/nomad"
attribute :data_dir, :kind_of => String, :default => "/tmp/nomad"
attribute :name, :kind_of => String, :default => "default-server-name"
attribute :bind_addr, :kind_of => String, :default => "127.0.0.1"
attribute :num_schedulers, :kind_of => Integer, :default => 1
attribute :bootstrap_expect, :kind_of => Integer, :default => 1
attribute :servers, :kind_of => Array, :default => ["127.0.0.1"]