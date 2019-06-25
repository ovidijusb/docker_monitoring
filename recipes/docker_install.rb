docker_service 'default' do
  action [:create, :start]
end

docker_network 'v-net' do
  subnet '192.168.26.0/24'
  ip_range '192.168.26.0/24'
  gateway '192.168.26.1'
end
