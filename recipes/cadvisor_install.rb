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

systemd_unit 'cadvisor.service' do
  content <<-SUL.gsub(/^\s+/, '')
  [Unit]
  Description=cAdvisor

  [Service]
  User=root
  ExecStart=/usr/local/bin/cadvisor

  [Install]
  WantedBy=multi-user.target
  SUL
  action [:create, :enable, :start]
end
