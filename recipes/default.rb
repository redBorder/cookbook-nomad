#
# Cookbook Name:: cookbook-example
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

num_schedulers = if(cpu["total"] <= 1) 1 else cpu["total"] - 1

nomad_server "server" do
  name "nomad-server-1"
  bind_addr node["ipaddress"]
  num_schedulers num_schedulers
  action :add
end
