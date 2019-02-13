# docker-collectd-prom

Inspired by https://github.com/fr3nd/docker-collectd 

This image is ready to collect host system stats and send them to the `prometheus`.
Also here is the configuration file for collectd that contains:
- enabled plugin `write_prometheus` listening on the non-standard `9105` port
- enabled percentage of the CPU load in the `cpu` plugin (that's handy!)
- enabled plugin `exec` in order to use capability of loading STDOUT of shell scripts to the `collectd`:
	- added user `script_user` which is capable for running shell scripts for `exec`
	- added folder `/monitoring_scripts` with `script_user` as owner to which external monitoring scripts can be bind-mounted
- `df` plugin mountpoint redirected to the `/hostfs` folder

## Usage

#### Run with config provided in the repository

```bash
sudo docker run -d --privileged \
	-p 9105:9105 \
	-v /proc:/mnt/proc:ro \
	-v /:/hostfs:ro \
	frankelvin/docker_collectd_prom
```

#### Run with own config (if case of changes in config file)
```bash
sudo docker run -d --privileged \
	-p 9105:9105 \
	-v <path to config on disk>:/etc/collectd/collectd.conf \
	-v /proc:/mnt/proc:ro \
	-v /:/hostfs:ro \
	-v <path to monitoring scripts on disk>:/monitoring_scripts \
	frankelvin/docker_collectd_prom
```

## FAQ

### Do you need to run the container as privileged?
Yes. Collectd needs access to the parent host's `/proc` filesystem to get statistics. It's possible to run collectd without passing the parent host's `/proc` filesystem without running the container as privileged, but the metrics would not be acurate.

### Do you need to mount entire `/`?
Yes. Without the `/` mounted collectd won't be able to gather `df` stats for every partition that exists on the server.
