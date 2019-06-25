directory '/root/grafana_container' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/root/grafana_container/Dockerfile' do
  source 'grafana_container/Dockerfile'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]'
end

template '/root/grafana_container/datasource.yaml' do
  source 'grafana_container/datasource.yaml'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]'
end

template '/root/grafana_container/dashboard.yaml' do
  source 'grafana_container/dashboard.yaml'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]'
end

template '/root/grafana_container/cadvisor_dashboard.json' do
  source 'grafana_container/cadvisor_dashboard.json'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]'
end

template '/root/grafana_container/node_exporter_dashboard.json' do
  source 'grafana_container/node_exporter_dashboard.json'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[grafana]'
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
  port '3000:3000'
  env ['GF_SECURITY_ADMIN_PASSWORD=foobar', 'GF_USERS_ALLOW_SIGN_UP=false']
  host_name 'grafana'
  network_mode 'v-net'
  action :run
end
