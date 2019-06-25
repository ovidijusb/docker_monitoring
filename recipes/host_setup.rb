# Add golang repo
yum_repository 'go-repo' do
  description 'go-repo - CentOS'
  baseurl 'https://mirror.go-repo.io/centos/$releasever/$basearch/'
  gpgkey 'https://mirror.go-repo.io/centos/RPM-GPG-KEY-GO-REPO'
  action :create
end

sysctl_param 'kernel.perf_event_paranoid' do
  value '-1'
end

selinux_state 'set_permissive' do
  action :permissive
end

package 'git'
package 'glibc-static'
package 'golang'
