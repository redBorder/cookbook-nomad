# Cookbook Name:: nomad
#
# Resource:: client
#

actions :add, :remove
default_action :add

attribute :user, :kind_of => String, :default => "nomad"
attribute :group, :kind_of => String, :default => "nomad"
attribute :log_dir, :kind_of => String, :default => "/var/log/nomad"
attribute :data_dir, :kind_of => String, :default => "/tmp/nomad/client"
attribute :name, :kind_of => String, :default => "default-client-name"
attribute :bind_addr, :kind_of => String, :default => "127.0.0.1"
attribute :servers, :kind_of => Array, :default => ["127.0.0.1"]
attribute :cpu_mhz, :kind_of => Integer, :default => 500
attribute :memory_mb, :kind_of => Integer, :default => 512
attribute :disk_mb, :kind_of => Integer, :default => 5120