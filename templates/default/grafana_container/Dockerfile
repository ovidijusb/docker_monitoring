FROM grafana/grafana 
#  COPY grafana.ini /etc/grafana/grafana.ini	
COPY datasource.yaml /etc/grafana/provisioning/datasources/datasource.yaml
COPY dashboard.yaml /etc/grafana/provisioning/dashboards/dashboard.yaml
COPY cadvisor_dashboard.json /etc/grafana/provisioning/dashboards/cadvisor_dashboard.json
COPY node_exporter_dashboard.json /etc/grafana/provisioning/dashboards/node_exporter_dashboard.json
