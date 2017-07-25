# dockerfile-lab
Lab de Dockerfile do curso Application Development with Red Hat OpenShift


#### 1 - Create a directory in your file system called busyBox_project and change your working directory to it
```
$ cd $HOME
$ mkdir busyBox_project
$ cd busyBox_project
```

#### 2 - In the busyBox_project directory, create a shell script called loveLXC.sh
```
#!/bin/sh

# If command line parameter has been included, use it as our $ENTITY variable
if [ "$#" -eq 0 ]; then
   ENTITY="Red Hat"
else
   ENTITY=$@
fi

# If LOVE_LXC_DIR env var is not set, then set default value
if [ "x$LOVE_LXC_DIR" = "x" ]; then
   LOVE_LXC_DIR=/tmp
fi

OUTPUT_FILE="super_top_secret_log.log"

while true; do

  # Write to standard output
  echo "$ENTITY loves linux containers";

  # Write to output file
  echo "$ENTITY loves linux containers" >> $LOVE_LXC_DIR/$OUTPUT_FILE

  sleep 5s;
done
```

#### 3 - Make the shell script executable
```
$ chmod 755 loveLXC.sh
```

#### 4 - Create a Dockerfile that instructs Docker to add your shell script to the BusyBox base image and execute that shell script on container startup:
a) Create a text file called Dockerfile in the busyBox_project directory.
b) Add the following contents to Dockerfile:
```
# Example of very simple Dockerfile based on minimalistic BusyBox base image
# Please read through each comment to gain a better understanding of what this Dockerfile does

# Docker will pull from docker.io if base image does not already exist in local Docker repo
FROM busybox

# Feel free to modify this
MAINTAINER "Red Hat Global Partner Technical Enablement <open-program@redhat.com>"

# The LABEL instruction adds metadata to an image. A LABEL is a key-value pair.
LABEL version="1.0" \
      description="This is our first project that creates a custom Docker image based on the extremely small BusyBox base image"

# Define two environment variables: NAME and LOVE_LXC_DIR
# Value of env variables can be modified at container startup using -e parameter
ENV NAME="My enterprise IT shop" \
    LOVE_LXC_DIR="/var/lovelxc"

# Docker is to execute all subsequent commands in this file as BusyBox's root user
USER root

# /usr/local/bin/ is included in the root user's $PATH
# copy our shell script to this directory
COPY loveLXC.sh /usr/local/bin/loveLXC.sh

# Ensure that shell script added to image is set as executable
RUN chmod 755 /usr/local/bin/loveLXC.sh

# Create directory and define it as a container mount point
# Our shell script will write output to local filesystem at this mount point
CMD mkdir $LOVE_LXC_DIR
VOLUME $LOVE_LXC_DIR

# At startup, this container should run a single command
# Our script uses the command line parameters passed as part of $NAME env var
CMD /usr/local/bin/loveLXC.sh $NAME
```

#### 5 - Review the two simple text files of your completed Docker project
```
$ ls -lF
```
```
total 16
-rw-r--r--  1 wkulhane  staff  1521 Oct 11 14:26 Dockerfile
-rwxr-xr-x  1 wkulhane  staff   516 Oct 11 14:25 loveLXC.sh*
```

#### 6 - While still in the busyBox_project directory, build the Docker image
```
$ docker build --rm=true -t rhtgptetraining/lovelxc .
```

#### 7 - Note the presence of your new custom Docker image
```
$ docker images
```

#### 8 - Run a new container (without passing an environment variable) from your custom image
```
$ docker run -d --name="my-lovelxc-container" rhtgptetraining/lovelxc
```

#### 9 - Tail the standard output of the container
```
$ docker logs -f my-lovelxc-container
```

#### 10 - Review the standard output and press Ctrl+C when you are finished


#### 11 - Delete the existing container and re-instantiate using an environment variable
```
$ docker rm -f my-lovelxc-container
$ docker run -d --name="my-lovelxc-container" -e NAME="The world" rhtgptetraining/lovelxc
```

#### 12 - Again, tail the standard output:
```
$ docker logs -f gpte-lovelxc
```

#### 13 - Review the output of this new container and press Ctrl+C when finished.


### Examine Mounted Volume

#### 14 - Execute the docker inspect command and retrieve the path on the host operating system to the container volume
```
$ docker inspect -f '{{json .Mounts}}' gpte-lovelxc | jq
```
```
[
    {
        "Destination": "/var/lovelxc",
        "Driver": "local",
        "Mode": "",
        "Name": "3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705",
        "Propagation": "",
        "RW": true,
        "Source": "/var/lib/docker/volumes/3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705/_data"
    }
]
```

#### 15 - View the contents of the file written by the script to this external volume on the host operating system
```
$ cat /var/lib/docker/volumes/3f249a116633074e34840ddea836f26a570b7ef36bcdb01cdbd22f8f37cf4705/_data/super_top_secret_log.log  | more
```
```
The world loves linux containers
The world loves linux containers
The world loves linux containers
```

#### 16 - Delete the running container
```
$ docker rm -f gpte-lovelxc
```
 
#### 17 - Delete the image
```
$ docker rmi rhtgptetraining/lovelxc
```

#### 18 - Delete the busybox base image
```
$ docker rmi busybox
```
