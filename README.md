# Auto Update BDS

### Created to automatically update to the latest stable release of the **linux** bedrock_server

```sh
#!/bin/bash

versionUrl=$(wget -q -O - "https://net-secondary.web.minecraft-services.net/api/v1.0/download/links" | grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-[^"]*\.zip')
version=$(echo "$versionUrl" | grep -oP 'bedrock-server-\K\d+\.\d+\.\d+\.\d+')
echo "latest $version"

mkdir versions &> /dev/null
wget -q -U "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0" $versionUrl -O "versions/$version.zip"

mkdir internal &> /dev/null

# -u might update the server automatically i have no clue... we'll just delete it incase.
rm internals/current/bedrock_server &> /dev/null
unzip -u "versions/$version.zip" -d "internal"

cd "internal"
./bedrock_server```
