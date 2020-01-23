#!/usr/bin/env bash

rsyslogd -n &
/usr/sbin/sshd -D &
tail -F /var/log/auth.log &
wait -n
