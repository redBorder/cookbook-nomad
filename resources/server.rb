# Cookbook Name:: nomad
#
# Resource:: config
#

actions :add, :remove
default_action :add

attribute :user, :kind_of => String, :default => node.nomad.user
attribute :group, :kind_of => String, :default => node.nomad.group
attribute :log_dir, :kind_of => String, :default => node.nomad.log_dir
attribute :data_dir, :kind_of => String :default => node.nomad.data_dir
attribute :name, :kind_of => String, :default => "default-name"
attribute :bind_addr, :kind_of => String, :default => "127.0.0.1"
attribute :num_schedulers, :kind_of => Integer, :default => 1
attribute :bootstrap_expect, :kind_of => Integer, :default => 1
attribute :servers, :kind_of => Array, :default => ["127.0.0.1"]
