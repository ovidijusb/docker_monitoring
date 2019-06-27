# Add golang repo
yum_repository 'go-repo' do
  description 'go-repo - CentOS'
  baseurl 'https://mirror.go-repo.io/centos/$releasever/$basearch/'
  gpgkey 'https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO'
  action :create
end

# sysctl params for node_exporter
sysctl_param 'kernel.perf_event_paranoid' do
  value '-1'
end

selinux_state 'set_permissive' do
  action :permissive
end

execute 'node_exporter_iptables_rule' do
  command "/sbin/iptables -A INPUT ! -s #{node['network']['private_net']} -p tcp --dport #{node['node_exporter']['port']} -j DROP"
  not_if "/usr/sbin/iptables -L INPUT -n | grep #{node['node_exporter']['port']}"
  action :run
end

execute 'cadvisor_iptables_rule' do
  command "/sbin/iptables -A INPUT ! -s #{node['network']['private_net']} -p tcp --dport #{node['cadvisor']['port']} -j DROP"
  not_if "/usr/sbin/iptables -L INPUT -n | grep #{node['cadvisor']['port']}"
  action :run
end

execute 'prometheus_iptables_rule' do
  command "/sbin/iptables -A INPUT ! -s #{node['network']['private_net']} -p tcp --dport #{node['prometheus']['port']} -j DROP"
  not_if "/usr/sbin/iptables -L INPUT -n | grep #{node['prometheus']['port']}"
  action :run
end

package 'git'
package 'glibc-static'
package 'golang'
