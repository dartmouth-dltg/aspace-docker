# ArchivesSpace

## Note re: start-archivesspace.sh
The Dockerfile loads in the start-archivesspace.sh script which will
run any pending database migrations and then start the application. A full reindex
can also be triggered.

## Setup & testing

The setup assumes that the base ArchivesSpace application is located in a subdirectory
named 'archivesspace', that your plugins are located in a subdirectory names 'plugins',
and that the mysql java connector is in the top level directory. 

Note that Dartmouth also runs an Apache container in front of the ArchivesSpace container
for additional access control.

Create the mounts. You can create these anywhere convenient - `/tmp` used for
these instructions.

```sh
mkdir -p /tmp/archivesspace-mounts/secrets
mkdir /tmp/archivesspace-mounts/data

# Secrets for remote database
echo 'REMOVED' > /tmp/archivesspace-mounts/secrets/DB_PASS_FILE

# Secrets for local database
echo 'REMOVED' > /tmp/archivesspace-mounts/secrets/DB_PASS_FILE_LOCAL
```

Build

```sh
docker build -t archivesspace-web .
```

Run locally via localhost database

```sh
docker rm -f archivesspace-web
docker run -d \
--name archivesspace-web \
-e DB_HOST='host.docker.internal' \
-e DB_PORT='3306' \
-e DB_NAME='{LOCAL_DB_NAME}' \
-e DB_USER='{LOCAL_DB_USERNAME}' \
-e PUI_HOST='' \
-e DB_PASS_FILE='/etc/secrets/DB_PASS_FILE_LOCAL' \
-v /tmp/archivesspace-mounts/data:/opt/archivesspace/data \
-v /tmp/archivesspace-mounts/secrets:/etc/secrets \
-p 8080:8080 \
-p 8089:8089 \
-p 8081:8081 \
archivesspace-web
docker logs -f archivesspace-web
```

If you are running other services, you can change the port binding - e.g. bind
the staff interface 8080 to localhost:8070

```
-p 8070:8080 \
```

Standard setup for running in a container connecting to a remotely hosted database.

```sh
docker rm -f archivesspace-web
docker run -d \
--name archivesspace-web \
-e DB_HOST='{URL_TO_REMOTE_DB}' \
-e DB_PORT='3306' \
-e DB_NAME='{REMOTE_DB_NAME}' \
-e DB_USER='{REMOTE_DB_USERNAME}' \
-e PUI_HOST='' \
-e DB_PASS_FILE='/etc/secrets/DB_PASS_FILE' \
-v /tmp/archivesspace-mounts/data:/opt/archivesspace/data \
-v /tmp/archivesspace-mounts/secrets:/etc/secrets \
-p 8080:8080 \
-p 8089:8089 \
-p 8081:8081 \
archivesspace-web
docker logs -f archivesspace-web
```

