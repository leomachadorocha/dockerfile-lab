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
