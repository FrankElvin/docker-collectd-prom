# docker_collectd_prom

Inspired by https://github.com/fr3nd/docker-collectd 

This image is ready to collect host system stats and send them to the `prometheus` system.
Also here is the configuration file for collectd that contains:
- enabled plugin `write_prometheus` listening on the `9105` port
- redirection of the `df` plugin to the `/hostfs` folder

## Usage

```bash
sudo docker run -d --privileged \
	-p 9105:9105 \
	-v <path to config on disc>:/etc/collectd/collectd.conf \
	-v /proc:/mnt/proc:ro \
	-v /:/hostfs:ro \
	frankelvin/docker_collectd_prom
```

## FAQ

### Do you need to run the container as privileged?
Yes. Collectd needs access to the parent host's /proc filesystem to get statistics. It's possible to run collectd without passing the parent host's /proc filesystem without running the container as privileged, but the metrics would not be acurate.

### Do I need to mount entire `/`?
Yes. Without the `/` mounted collectd won't be able to gather `df` stats for every partition that exists on the server.
