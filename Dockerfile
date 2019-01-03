FROM debian

RUN apt-get update
RUN apt-get install -y collectd

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
