#!/bin/bash

if [ ! -z "$MLDONKEY_UID" ]; then
    echo "Resetting mldonkey uid to $MLDONKEY_UID"
    usermod -u $MLDONKEY_UID mldonkey
fi

if [ ! -z "$MLDONKEY_GID" ]; then
    echo "Resetting mldonkey gid to $MLDONKEY_GID"
    groupmod -g $MLDONKEY_GID mldonkey
fi

chown mldonkey:mldonkey -R /var/lib/mldonkey

su - -l mldonkey -c /entrypoint.sh