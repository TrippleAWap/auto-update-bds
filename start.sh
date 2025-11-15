#!/usr/bin/env bash
set -euo pipefail

url=$(wget -qO- https://net-secondary.web.minecraft-services.net/api/v1.0/download/links |
      grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-[^"]*\.zip')
ver=${url##*/bedrock-server-}
ver=${ver%.zip}
echo "latest $ver"

wget -qU "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0" \
     "$url" -O "$ver.zip"

unzip -n "$ver.zip" -d .

chmod +x bedrock_server
exec ./bedrock_server
