#
# Cookbook Name:: nomad
# Recipe:: default
#
# Copyright 2016, redborder
#
# AFFERO GENERAL PUBLIC LICENSE V3
#
require 'pry'

## Configure Client Server

# Compute the total cpu mhz over all CPUs and use the 90%.
total_cpu_mhz = (node['cpu'].select{|k,v| k =~ /[[:digit:]]/ }.values.map{ |v| v['mhz'].to_f }.compact.inject(0){|total_mhz,cpu_mhz| total_mhz + cpu_mhz } * 0.90).to_i

# Compute the total memory (megabytes) and use the 90%.
memory_mb = (node['memory']['total'].match(/\A(?<value>\d+)(?<modifier>\w+)\z/)[:value].to_i / 1024 * 0.90).to_i

nomad_client "client" do
  name "nomad-client-1"
  bind_addr node['ipaddress']
  servers ["#{node['hostname']}"]
  cpu_mhz total_cpu_mhz
  memory_mb memory_mb
  action :add
end

## Configure Nomad Server
num_schedulers = node['cpu']['total'] <= 1 ? 1 : node['cpu']['total'] - 1
                 
nomad_server "server" do
  name "nomad-server-1"
  bind_addr node['ipaddress']
  num_schedulers num_schedulers
  servers ["#{node['hostname']}"]
  action :add
end


