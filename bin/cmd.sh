#!/usr/bin/env bash

rsyslogd -n &
/usr/sbin/sshd -D &
tail -f /var/log/auth.log &
wait -n
