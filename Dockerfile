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
