name 'docker_monitoring'
maintainer 'Ovidijus Boiko'
maintainer_email 'ovidijus@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures Docker monitoring'
long_description 'Installs/Configures the Docker service, Node Exporter, cAdvisor on host and Prometeus/Grafana as Docker containers.'
version '0.1.0'
chef_version '>= 12.14' if respond_to?(:chef_version)

# The `issues_url` points to the location where issues for this cookbook are
# tracked.  A `View Issues` link will be displayed on this cookbook's page when
# uploaded to a Supermarket.
#
# issues_url 'https://github.com/<insert_org_here>/docker_monitoring/issues'

# The `source_url` points to the development repository for this cookbook.  A
# `View Source` link will be displayed on this cookbook's page when uploaded to
# a Supermarket.
#
# source_url 'https://github.com/<insert_org_here>/docker_monitoring'
depends 'docker'
depends 'sysctl'
depends 'selinux'
