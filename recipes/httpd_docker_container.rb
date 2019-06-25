directory '/root/httpd_container' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

template '/root/httpd_container/Dockerfile' do
  source 'httpd_container/Dockerfile'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[httpd]'
end

template '/root/httpd_container/index.html' do
  source 'httpd_container/index.html'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :redeploy, 'docker_container[httpd]'
end

docker_image 'local/httpd' do
  tag 'latest'
  source '/root/httpd_container'
  action :build
end

docker_container 'httpd' do
  repo 'local/httpd'
  tag 'latest'
  port '80:80'
  host_name 'httpd'
  network_mode 'v-net'
  action :run
end
