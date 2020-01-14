# sshd
Dockerized sshd daemon

## Run
```
NAME="sshd"
BASE_DIR="/srv/data/docker/containers/${NAME}"
OPTIONS=""
[ -d "${BASE_DIR}/etc" ] && OPTIONS="-v $BASE_DIR/etc:/etc -v $BASE_DIR/home:/home -v $BASE_DIR/root:/root"
docker run -d -p 2022:22 --name ${NAME} --hostname ${NAME} --restart=always $OPTIONS neomediatech/sshd
```

## Options
/etc, /root, /home should be exists in order to customi[s|z]e your sshd server

## How to customi[s|z]e
- create a folder where you want, for ex `mkdir -p ~/custom_ssh`
- run `docker run --rm -it -v ~/custom_ssh:/data neomediatech/sshd bash`
- inside the container run `cp -ar /{etc,root,home} /data/`
- `exit`
- Now you can run the container mounting that directories and customi[s|z]e what you desire, for ex you can create some user, change /etc/ssh/sshd_config config, and so on
