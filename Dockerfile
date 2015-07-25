FROM hub.maestro.io:5000/crisidev/debian

RUN apt-get update && apt-get -y install libfontconfig wget adduser openssl ca-certificates

RUN wget http://grafanarel.s3.amazonaws.com/builds/grafana_latest_amd64.deb

RUN dpkg -i grafana_latest_amd64.deb

RUN mkdir -p /var/lib/grafana
ADD grafana.ini /etc/grafana/
ADD grafana.db /var/lib/grafana/
ADD prometheus /usr/share/grafana/public/app/plugins/datasource/prometheus

EXPOSE 3001
WORKDIR /usr/share/grafana
ENTRYPOINT ["/usr/sbin/grafana-server", "--config", "/etc/grafana/grafana.ini"]
