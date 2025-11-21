set -euo pipefail

BASE_DIR=$(pwd)
VERSION_FILE="${BASE_DIR}/bds_version.txt"
BEDROCK_BIN="${BASE_DIR}/bedrock_server"

url=$(wget -qO- https://net-secondary.web.minecraft-services.net/api/v1.0/download/links |
      grep -o 'https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-[^"]*\.zip')
latest_ver=${url##*/bedrock-server-}
latest_ver=${latest_ver%.zip}
echo "latest $latest_ver"

if [[ -f "$VERSION_FILE" ]]; then
    current_ver=$(<"$VERSION_FILE")
else
    current_ver="none"
fi

if [[ "$current_ver" == "$latest_ver" && -x "$BEDROCK_BIN" ]]; then
    echo "Server already at latest version ($latest_ver). Skipping download."
else
    echo "Updating to $latest_ver …"
    wget -qU "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:136.0) Gecko/20100101 Firefox/136.0" \
         "$url" -O "${BASE_DIR}/${latest_ver}.zip"
    rm "${BEDROCK_BIN}"
    unzip -n "${BASE_DIR}/${latest_ver}.zip" -d "$BASE_DIR"
    echo "$latest_ver" > "$VERSION_FILE"
fi

chmod +x "$BEDROCK_BIN"
