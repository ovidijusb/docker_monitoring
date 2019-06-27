docker_service 'default' do
  action %i[create start]
end

docker_network 'private_net' do
  subnet node['network']['private_net']
  ip_range node['network']['private_net']
  gateway node['network']['gateway']
end
