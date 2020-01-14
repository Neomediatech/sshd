#!/bin/bash

if [ ! -d /run/sshd ]; then
    mkdir -p /run/sshd
fi

exec "$@"
