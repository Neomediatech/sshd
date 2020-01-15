#!/usr/bin/env bash

[ ! -d /run/sshd ] && mkdir -p /run/sshd
[ ! -f /var/log/auth.log ] && touch /var/log/auth.log && chmod 666 /var/log/auth.log

if [ -f /data/shadow ]; then
   chown root:shadow /data/shadow && chmod 640 /data/shadow

   rpwd="$(cat /data/shadow|grep ^root:)"
   [ $? -eq 0 ] && sed -i "s@^root:.*@${rpwd}@" /etc/shadow

   uid=1000
   sudoers=""
   for u in $(cat /data/shadow | grep -v ^root: | awk -F: '{print $1}'); do
      grep -q $u: /etc/shadow
      if [ $? -eq 1 ]; then
        echo "$u:x:$uid:$uid::/home/$u:/bin/bash" >> /etc/passwd
        echo "$u:x:$uid:" >> /etc/group
        [ ! -d /home/$u ] && mkdir -p /home/$u && chown $u:$u /home/$u
        if [ "$sudoers" = "" ]; then
           sudoers="$u"
        else
           sudoers="$sudoers,$u"
        fi
        uid=$[$uid + 1]
	cat /data/shadow | grep ^$u: >> /etc/shadow
      fi
   done

   if [ "$sudoers" != "" ]; then
     sed -i "s@^sudo:.*@sudo:x:27:${sudoers}@" /etc/group
   fi
fi

which ssh 1>/dev/null
if [ $? -eq 1 ]; then
   apt update && apt install -y --no-install-recommends openssh-server && \
   rm -rf /var/lib/apt/lists*
fi

exec "$@"
