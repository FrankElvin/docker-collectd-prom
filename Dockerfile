FROM debian

RUN apt-get update
RUN apt-get install -y collectd

ADD entrypoint.sh /entrypoint.sh
ADD collectd.conf /etc/collectd/collectd.conf
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
