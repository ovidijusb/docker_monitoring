directory '/root/prometheus_container' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/root/prometheus_container/Dockerfile' do
  source 'prometheus_container/Dockerfile'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[prometheus]'
end

template '/root/prometheus_container/prometheus.yml' do
  source 'prometheus_container/prometheus.yml'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[prometheus]'
end

docker_image 'local/prometheus' do
  tag 'latest'
  source '/root/prometheus_container'
  action :build
end

docker_container 'prometheus' do
  repo 'local/prometheus'
  tag 'latest'
  port '9090:9090'
  volume 'prometheus_data:/prometheus'
  host_name 'prometheus'
  network_mode 'v-net'
  action :run
end
