#!/bin/bash
if [ ! -e /var/cache/munin/www/index.html ]; then
cat << EOF > /var/cache/munin/www/index.html
<html>
<head>
  <title>Munin</title>
</head>
<body>
Munin has not run yet.  Please try again in a few moments.
</body>
</html>
EOF
chown munin:munin -R /var/cache/munin/www
chown munin:munin /var/lib/munin
chmod g+w /var/cache/munin/www/index.html
fi

# start cron
/usr/sbin/cron
service munin-node start
# start apache
/usr/sbin/apache2ctl -DFOREGROUND
