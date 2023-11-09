#!/usr/bin/env bash

rm -f /run/rsyslogd.pid
rsyslogd -n &
/usr/sbin/sshd -D &
tail -F /var/log/auth.log &
wait -n
