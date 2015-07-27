FROM ubuntu:14.04.2
RUN apt-get update
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y apache2 apache2-utils
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y libcgi-fast-perl libapache2-mod-fcgid
RUN RUNLEVEL=1 DEBIAN_FRONTEND=noninteractive apt-get install -y munin
RUN (sed -i 's/^\s*Allow from .*/        Allow from all\n        Require all granted/g' /etc/munin/apache.conf)
RUN chown munin:munin /var/lib/munin
ADD run.sh /usr/local/bin/run
RUN chmod +x /usr/local/bin/run
VOLUME /var/lib/munin
VOLUME /var/log/munin
VOLUME /etc/munin/munin-conf.d
EXPOSE 80
CMD ["/usr/local/bin/run"]
