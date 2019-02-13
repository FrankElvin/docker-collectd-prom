FROM debian

RUN apt-get update
RUN apt-get install -y collectd

RUN adduser --disabled-password --gecos "" script_runner
RUN mkdir /monitoring_scripts
RUN chmod 777 /monitoring_scripts
RUN chown script_runner /monitoring_scripts

ADD entrypoint.sh /entrypoint.sh
ADD collectd.conf /etc/collectd/collectd.conf
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
