directory '/root/prometheus_container' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/root/prometheus_container/Dockerfile' do
  source 'prometheus_container/Dockerfile'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[prometheus]', :delayed
end

template '/root/prometheus_container/prometheus.yml' do
  source 'prometheus_container/prometheus.yml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(host_ip: node['network']['gateway'], prometheus_port: node['prometheus']['port'], node_exporter_port: node['node_exporter']['port'], cadvisor_port: node['cadvisor']['port'])
  notifies :redeploy, 'docker_container[prometheus]', :delayed
end

docker_image 'local/prometheus' do
  tag 'latest'
  source '/root/prometheus_container'
  action :build
end

docker_container 'prometheus' do
  repo 'local/prometheus'
  tag 'latest'
  port "#{node['prometheus']['port']}:#{node['prometheus']['port']}"
  volume 'prometheus_data:/prometheus'
  host_name 'prometheus'
  network_mode 'private_net'
  action :run
end
