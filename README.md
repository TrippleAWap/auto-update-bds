# Auto Update BDS

### Created to automatically update to the latest stable release of the **linux** bedrock_server
___

#### One Liner
```sh
wget -O update_bds.sh https://raw.githubusercontent.com/TrippleAWap/auto-update-bds/refs/heads/root/start.sh && bash update_bds.sh
```

#### Service File
```service
[Unit]
Description=Bedrock Dedicated Server
After=network.target

[Service]
Type=forking
User=root
WorkingDirectory=/root/bedrock_server/bds

ExecStartPre=/usr/bin/bash /root/bedrock_server/auto_update.sh

ExecStart=/usr/bin/screen -dmS bds -L -Logfile /var/log/bds.log /root/bedrock_server/bds/bedrock_server

ExecStop=/usr/bin/screen -S bds -X quit

Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```
