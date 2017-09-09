# phabricatory
A (preliminary) [Phabricator](https://www.phacility.com/phabricator/) docker image builder with [Wikimedia Sprint](https://github.com/wikimedia/phabricator-extensions-Sprint). Moreover all the prototyped application, like _Calendar_ and many others, are also activated.

I've used [RedpointGames/phabricator](https://github.com/RedpointGames/phabricator) as initial image. Cloning this project and rebuilding from scratch the inizial image does not work, for a [error](https://hub.docker.com/r/hachque/systemd-none/builds/) in the _hachque/systemd-none_ inizial image of redpointgames/phabricator.

## Usage
You can use the `Dockerfile` to build the image just like
```
docker build -t phabricatory .
```

## Running
Please, for configuration detalis refer to the above links.
You're strongly encouraged to use a **docker-compose** file like that below.

### Startup
1. Set your PHABRICATOR_HOST in the docker-compose file. Phabricator needs this.
2. Set yout basepath for implementing data persistence
3. run first `docker-compose create mysql`, then `docker-compose start mysql` and wait for mysql container makes his steps
4. stop the mysql container
5. run `docker-compose up`
After the startup, point your browser to `http://PHABRICATOR_HOST`

### docker-compose.yaml
```
## docker-compose.yaml
version: '3.2'

services:
  mysql:
    image: mysql
    container_name: mysql
    ports:
      - 33060:3306
    environment:
      MYSQL_ROOT_PASSWORD: password
      MYSQL_USER: phabricator
      MYSQL_PASSWORD: phabricator
      MYSQL_DATABASE: phabricator
    volumes:
      - type: bind
        source: <your_basepath>/data
        target: /var/lib/mysql

  phabricator:
    image: paskaly/phabricator
    container_name: pha
    links:
      - mysql
    depends_on:
      - mysql
    ports:
      - 80:80
      - 443:443
      - 22:22

    environment:
      MYSQL_HOST: mysql
      MYSQL_USER: root
      MYSQL_PASS: password
      PHABRICATOR_HOST: yourdomain.com
      PHABRICATOR_REPOSITORY_PATH: /repos
      PHABRICATOR_STORAGE_TYPE: disk
      PHABRICATOR_STORAGE_PATH: /files

    volumes:
      - type: bind
        source: <your_basepath>/repository
        target: /repos
      - type: bind
        source: <your_basepath>/files
        target: /files
      - type: bind
        source: <your_basepath>/extensions
        target: /srv/phabricator/phabricator/src/extensions
```
