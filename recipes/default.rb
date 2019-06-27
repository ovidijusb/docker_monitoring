#
# Cookbook:: docker_monitoring
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

include_recipe 'docker_monitoring::host_setup'
include_recipe 'docker_monitoring::docker_install'
include_recipe 'docker_monitoring::node_exporter_install'
include_recipe 'docker_monitoring::cadvisor_install'
include_recipe 'docker_monitoring::prometheus_docker_container'
include_recipe 'docker_monitoring::grafana_docker_container'
