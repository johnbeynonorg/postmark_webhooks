#!/usr/bin/env bash
# exit on error
set -o errexit

npm install

SRC_DIR=$HOME/project/src
mkdir -p $SRC_DIR/vendor
VENDOR_DIR=$SRC_DIR/vendor

if [[ ! -d $XDG_CACHE_HOME/vendor ]]; then
  curl -sS https://install.meteor.com/ | HOME=$VENDOR_DIR /bin/sh
  cp -R $VENDOR_DIR $XDG_CACHE_HOME/ # cache it
else
  echo "...Using Meteor from build cache"
  cp -R $XDG_CACHE_HOME/vendor $SRC_DIR/ # restore from cache
fi

export PATH="$PATH:$VENDOR_DIR/.meteor" 

meteor build --server-only --server $RENDER_EXTERNAL_URL --directory $SRC_DIR/app