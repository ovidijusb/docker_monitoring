directory '/root/grafana_container' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

cookbook_file '/root/grafana_container/Dockerfile' do
  source 'grafana_container/Dockerfile'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]', :delayed
end

template '/root/grafana_container/datasource.yaml' do
  source 'grafana_container/datasource.yaml.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(prometheus_url: node['prometheus']['url'], prometheus_port: node['prometheus']['port'])
  notifies :redeploy, 'docker_container[grafana]', :delayed
end

cookbook_file '/root/grafana_container/dashboard.yaml' do
  source 'grafana_container/dashboard.yaml'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]', :delayed
end

template '/root/grafana_container/cadvisor_dashboard.json' do
  source 'grafana_container/cadvisor_dashboard.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(desc: node['grafana']['dashboard']['cadvisor_desc'], title: node['grafana']['dashboard']['cadvisor_title'])
  notifies :redeploy, 'docker_container[grafana]', :delayed
end

template '/root/grafana_container/node_exporter_dashboard.json' do
  source 'grafana_container/node_exporter_dashboard.json.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(desc: node['grafana']['dashboard']['node_exporter_desc'], title: node['grafana']['dashboard']['node_exporter_title'])
  notifies :redeploy, 'docker_container[grafana]', :delayed
end

docker_image 'local/grafana' do
  tag 'latest'
  source '/root/grafana_container'
  action :build
end

docker_container 'grafana' do
  repo 'local/grafana'
  tag 'latest'
  volume 'grafana_data:/var/lib/grafana'
  port "#{node['grafana']['port']}:#{node['grafana']['port']}"
  env 'GF_USERS_ALLOW_SIGN_UP=false'
  host_name 'grafana'
  network_mode 'private_net'
  action :run
end
