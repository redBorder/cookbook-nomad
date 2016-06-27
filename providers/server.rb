# Cookbook Name:: nomad
#
# Provider:: server
#

action :add do
  begin
    config_dir = "/etc/nomad"
    user = new_resource.user
    group = new_resource.group
    name = new_resource.name
    data_dir = new_resource.data_dir
    log_dir = new_resource.log_dir
    bind_addr = new_resource.bind_addr
    num_schedulers = new_resource.num_schedulers
    bootstrap_expect = new_resource.bootstrap_expect
    servers = new_resource.servers

    service "nomad-server" do
      supports :status => true, :start => true, :restart => true, :reload => true
      action :nothing
    end

    user user do
      action :create
    end
 
    [ log_dir, data_dir, "#{data_dir}/server", "#{data_dir}/server/raft" ].each do |path|
        directory path do
          owner user
          group group
          mode 0700
        end
    end

    directory config_dir do
       owner "root"
       group "root"
       mode 0700
    end

    template "#{config_dir}/server.hcl" do
      source "server.hcl.erb"
      owner "root"
      group "root"
      cookbook "nomad"
      mode 0644
      retries 2
      variables(:name => name, :data_dir => data_dir, :bind_addr => bind_addr, 
                :num_schedulers => num_schedulers, :bootstrap_expect => bootstrap_expect, :servers => servers)
      notifies :restart, 'service[nomad-server]', :delayed
    end

   template "#{data_dir}/server/raft/peers.json" do
      source "peers.json.erb"
      owner user
      group group
      cookbook "nomad"
      mode 0644
      retries 2
      variables(:servers => servers)
      #notifies :restart, 'service[nomad-server]', :delayed
    end

    service "nomad-server" do
      supports :status => true, :start => true, :restart => true, :reload => true
      action :start, :delayed
    end

    Chef::Log.info("nomad server has been configured correctly.")
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    service "nomad-server" do
      supports :status => true, :start => true, :restart => true, :reload => true
      action :stop
    end

    dir_list = [
      config_dir,
      data_dir,
      log_dir
    ]    
    
    template_list = [
      "#{config_dir}/server.hcl"
    ]

    template_list.each do |temp|
       file temp do
         action :delete
       end
    end

    dir_list.each do |dir|
       directory dir do
         action :delete
       end
    end
 
    Chef::Log.info("nomad server has been deleted correctly.")
  rescue => e
    Chef::Log.error(e.message)
  end
end
