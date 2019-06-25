yum_repository 'node-exporter' do
  description 'Node Exporter repo'
  baseurl 'https://copr-be.cloud.fedoraproject.org/results/ibotty/prometheus-exporters/epel-7-$basearch/'
  gpgkey 'https://copr-be.cloud.fedoraproject.org/results/ibotty/prometheus-exporters/pubkey.gpg'
  action :create
end

package 'node_exporter'

systemd_unit 'node_exporter.service' do
  content <<-SUF.gsub(/^\s+/, '')
  [Unit]
  Description=Node Exporter

  [Service]
  User=node_exporter
  EnvironmentFile=/etc/sysconfig/node_exporter
  ExecStart=/usr/sbin/node_exporter $OPTIONS

  [Install]
  WantedBy=multi-user.target
  SUF
  action [:create, :enable, :start]
end
