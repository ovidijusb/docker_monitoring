# Inspec test for recipe docker_monitoring::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe os.name do
  it { should eq 'centos' }
end

describe package('git') do
  it { should be_installed }
end

describe package('golang') do
  it { should be_installed }
end

describe systemd_service('node_exporter') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end

describe systemd_service('cadvisor') do
  it { should be_enabled }
  it { should be_installed }
  it { should be_running }
end

describe iptables do
  it { should have_rule('-A INPUT ! -s 192.168.26.0/24 -p tcp -m tcp --dport 9100 -j DROP') }
end

describe iptables do
  it { should have_rule('-A INPUT ! -s 192.168.26.0/24 -p tcp -m tcp --dport 8080 -j DROP') }
end

describe iptables do
  it { should have_rule('-A INPUT ! -s 192.168.26.0/24 -p tcp -m tcp --dport 8080 -j DROP') }
end

describe port('9100') do
  it { should be_listening }
end

describe port('8080') do
  it { should be_listening }
end

describe port('9090') do
  it { should be_listening }
end

describe port('3000') do
  it { should be_listening }
end

describe docker_container(name: 'prometheus') do
  it { should exist }
  it { should be_running }
end

describe docker_container(name: 'grafana') do
  it { should exist }
  it { should be_running }
end
