#
# Cookbook Name:: Nomad
# Attributes:: default
#

default['nomad']['user'] = "nomad"
default['nomad']['group'] = "nomad"

default['nomad']['data_dir'] = "/tmp/nomad"
default['nomad']['log_dir'] = "/var/log/nomad"
default['nomad']['name'] = "default-name"
default['nomad']['bind_addr'] = "127.0.0.1"
default['nomad']['num_schedulers'] = 1
default['nomad']['bootstrap_expect'] = 1
default['nomad']['servers'] = ["127.0.0.1"]

default['nomad']['cpu_mhz'] = 500
default['nomad']['memory_mb'] = 512
default['nomad']['disk_mb'] = 5120
default['nomad']['node_class'] = "default"