bash 'install_cadvisor' do
  user 'root'
  code <<-BCL
  go get -d github.com/google/cadvisor
  cd ${GOPATH-$HOME/go}/src/github.com/google/cadvisor
  make build
  cp cadvisor /usr/local/bin
  BCL
  not_if { File.exist?('/usr/local/bin/cadvisor') }
end

template '/etc/sysconfig/cadvisor' do
  source 'cadvisor/cadvisor.erb'
  owner 'root'
  group 'root'
  mode '0644'
  variables(bind_ip: node['network']['gateway'], bind_port: node['cadvisor']['port'])
  notifies :restart, 'service[cadvisor.service]', :delayed
end

systemd_unit 'cadvisor.service' do
  content <<-SUL.gsub(/^\s+/, '')
  [Unit]
  Description=cAdvisor

  [Service]
  User=root
  EnvironmentFile=/etc/sysconfig/cadvisor
  ExecStart=/usr/local/bin/cadvisor $OPTIONS

  [Install]
  WantedBy=multi-user.target
  SUL
  action %i[create enable]
end

service 'cadvisor.service' do
  action :start
end
