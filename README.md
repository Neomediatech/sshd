# sshd
Dockerized sshd daemon

# What
This image will run a container listening on port 22 with OpenSSH daemon.
Users inside /data/shadow file will be added to the system with this settings:
- Users are created with uid starting from 1000 in sequence as seen in /data/shadow file
- Users will have the same groupname as username
- Users will be part of the group `sudo` hence they can become root
- You can also have `root` user in /data/shadow file

## Run
```
NAME="sshd"
BASE_DIR="/srv/data/docker/containers/${NAME}"
OPTIONS=""
PORT="2022"
[ -d "${BASE_DIR}/conf" ]   && OPTIONS="$OPTIONS -v $BASE_DIR/conf:/etc/ssh"
[ -f "${BASE_DIR}/shadowdir/shadow" ] && OPTIONS="$OPTIONS -v $BASE_DIR/shadowdir:/data"
[ -d "${BASE_DIR}/home" ]   && OPTIONS="$OPTIONS -v $BASE_DIR/home:/home"
[ -d "${BASE_DIR}/root" ]   && OPTIONS="$OPTIONS -v $BASE_DIR/root:/root"
docker run -d -p $PORT:22 --name ${NAME} --hostname ${NAME} --restart=always $OPTIONS neomediatech/sshd
```
If you want to keep logs then add commands below before `docker run`:
```
mkdir -p ${BASE_DIR}/logs && chmod 777 ${BASE_DIR}/logs && touch ${BASE_DIR}/logs/auth.log && \
         chmod 666 ${BASE_DIR}/logs/auth.log
OPTIONS="$OPTIONS -v $BASE_DIR/logs:/var/log"
```
## Options
$BASE_DIR/conf and $BASE_DIR/shadowdir/shadow should exists in order to customi[s|z]e your sshd server

## How to customi[s|z]e
### Custom openssh config
- create a folder where you want, for ex `mkdir -p ~/custom_ssh`
- run `docker run --rm -it -v ~/custom_ssh:/data neomediatech/sshd bash`
- inside the container run `cp -ar /etc/ssh /data/`
- `exit`
- Now you can run the container mounting that directory and customi[s|z]e what you desire
### Custom users
If you want to use some user inside this container (otherwise it's useless) you can bind mount a shadow file in /data/shadow container. This must contains only users you want to allow connect to this container. Keep in mind that every user will have permission to become root user through `sudo` command.

