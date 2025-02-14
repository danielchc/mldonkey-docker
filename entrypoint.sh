#!/bin/bash

export MLDONKEY_DIR=/var/lib/mldonkey


if [ ! -f $MLDONKEY_DIR/downloads.ini ]; then
    echo "First run, applying configuration..."
    $(mldonkey > /dev/null 2>&1 &)
    sleep 5
    /usr/lib/mldonkey/mldonkey_command  "set client_name ${MLDONKEY_CLIENT_NAME:-mldonkey}"
    /usr/lib/mldonkey/mldonkey_command  "set allowed_ips 0.0.0.0/0"
    /usr/lib/mldonkey/mldonkey_command  "set client_buffer_size 5000000"
    /usr/lib/mldonkey/mldonkey_command  "set enable_kademlia true"
    /usr/lib/mldonkey/mldonkey_command  "set enable_bittorrent false"
    /usr/lib/mldonkey/mldonkey_command  "set enable_overnet false"
    /usr/lib/mldonkey/mldonkey_command  "set enable_directconnect false"
    /usr/lib/mldonkey/mldonkey_command  "set enable_fileTP false"
    /usr/lib/mldonkey/mldonkey_command  "set max_hard_upload_rate 0"
    /usr/lib/mldonkey/mldonkey_command  "set max_hard_download_rate 0"
    /usr/lib/mldonkey/mldonkey_command  "set max_upload_slots 10"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-connect_only_preferred_server false"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-max_connected_servers 4"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-min_left_servers 5"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-firewalled-mode false"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-port 20562"
    /usr/lib/mldonkey/mldonkey_command  "set ED2K-upload_timeout 60."
    /usr/lib/mldonkey/mldonkey_command  "set max_concurrent_downloads 150"
    /usr/lib/mldonkey/mldonkey_command  "set filenames_utf8 true"
    /usr/lib/mldonkey/mldonkey_command  "set create_file_mode 664"
    /usr/lib/mldonkey/mldonkey_command  "set create_dir_mode 775"
    /usr/lib/mldonkey/mldonkey_command  "set create_file_sparse true" 
    /usr/lib/mldonkey/mldonkey_command  "save"
    /usr/lib/mldonkey/mldonkey_command  "kill"
fi

sed -i '0,/   port =/s/   port =.*/  port = 6209/' $MLDONKEY_DIR/donkey.ini
sed -i '0,/   port =/s/   port =.*/  port = 16965/' $MLDONKEY_DIR/donkey.ini
sed -i 's/  port =/   port =/' $MLDONKEY_DIR/donkey.ini


if [ ! -z "$MLDONKEY_ADMIN_PASSWORD" ]; then
    /usr/lib/mldonkey/mldonkey_command "useradd admin $MLDONKEY_ADMIN_PASSWORD"
fi


mldonkey
