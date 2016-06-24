# Cookbook Name:: nomad
#
# Provider:: client
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
    servers = new_resource.servers
    cpu_mhz = new_resource.cpu_mhz
    memory_mb = new_resource.memory_mb
    disk_mb = new_resource.disk_mb
    node_class = new_resource.node_class

    service "nomad-client" do
      supports :status => true, :start => true, :restart => true, :reload => true
      action :nothing
    end


    user user do
      action :create
    end
 
    [ log_dir, data_dir, "#{data_dir}/client" ].each do |path|
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

    template "#{config_dir}/client.hcl" do
      source "client.hcl.erb"
      owner "root"
      group "root"
      cookbook "nomad"
      mode 0644
      retries 2
      variables(:name => name, :data_dir => data_dir, :bind_addr => bind_addr, 
                :servers => servers, :cpu_mhz => cpu_mhz, :memory_mb => memory_mb,
                :disk_mb => disk_mb, :node_class => node_class)
      notifies :restart, 'service[nomad-client]', :delayed
    end

    Chef::Log.info("nomad client has been configured correctly.")
  rescue => e
    Chef::Log.error(e.message)
  end
end

action :remove do
  begin
    config_dir = "/etc/nomad"
    data_dir = new_resource.data_dir
    log_dir = new_resource.log_dir

    service "nomad-client" do
      supports :status => true, :start => true, :restart => true, :reload => true
      action :stop
    end

    dir_list = [
      config_dir,
      data_dir,
      log_dir
    ]    
    
    template_list = [
      "#{config_dir}/client.hcl"
    ]

    template_list.each do |temp|
       template temp do
         action :delete
       end
    end

    dir_list.each do |dir|
       directory dir do
         action :delete
       end
    end
 
    Chef::Log.info("nomad client  has been deleted correctly.")
  rescue => e
    Chef::Log.error(e.message)
  end
end
