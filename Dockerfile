from    base:latest
run     echo "deb http://ppa.launchpad.net/chris-lea/node.js/ubuntu precise main" >> /etc/apt/sources.list
run     echo "deb http://ppa.launchpad.net/chris-lea/redis-server/ubuntu precise main" >> /etc/apt/sources.list
run     apt-get update
run     apt-get install --force-yes -y nodejs redis-server
add     .  /app
expose  6379 6967
env     PORT 6967
cmd     ["sh", "-c", "sysctl vm.overcommit_memory=1 ; cd /redis ; /usr/bin/redis-server --logfile redis.log --dbfilename /redis/dump.rdb | (sleep 2 && /app/node_modules/.bin/pm2 start -x /app/app.js -- --cors)"]
