# sshd
Dockerized sshd daemon

## Run
```
NAME="sshd"
BASE_DIR="/srv/data/docker/containers/${NAME}"
OPTIONS=""
[ -d "${BASE_DIR}/conf" ]   && OPTIONS="$OPTIONS -v $BASE_DIR/conf:/etc/ssh"
[ -f "${BASE_DIR}/shadow" ] && OPTIONS="$OPTIONS -v $BASE_DIR/shadow:/data/shadow"
docker run -d -p 2022:22 --name ${NAME} --hostname ${NAME} --restart=always $OPTIONS neomediatech/sshd
```

## Options
$BASE_DIR/conf and $BASE_DIR/shadow should exists in order to customi[s|z]e your sshd server

## How to customi[s|z]e
- create a folder where you want, for ex `mkdir -p ~/custom_ssh`
- run `docker run --rm -it -v ~/custom_ssh:/data neomediatech/sshd bash`
- inside the container run `cp -ar /etc/ssh /data/`
- `exit`
- Now you can run the container mounting that directory and customi[s|z]e what you desire

## Why install openssh-server at container startup instead of at image creation?
Because on every container startup openssh create a new (server) ssh key. If you want to keep the same ssh key follow "How to customi[s|z]e" instructions above.

