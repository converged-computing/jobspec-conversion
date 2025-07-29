#!/bin/bash
#FLUX: --job-name=omnigibson-vscode
#FLUX: -c=8
#FLUX: --queue=svl
#FLUX: --urgency=16

set -e -o pipefail
USERNAME=$(whoami)
BASE_DIR="/cvgl2/u/$USERNAME"
if [ ! -d "$BASE_DIR" ]; then
    echo "Error: Directory $BASE_DIR does not exist. Please ask for a directory to be created."
    exit 1
fi
cd $BASE_DIR
VSCODE_CONFIG_DIR="$BASE_DIR/vscode-config"
if [ ! -d "$VSCODE_CONFIG_DIR" ]; then
    mkdir "$VSCODE_CONFIG_DIR" || { echo "Error creating $VSCODE_CONFIG_DIR"; exit 1; }
fi
EXTENSIONS_DIR="$VSCODE_CONFIG_DIR/extensions"
DATA_DIR="$VSCODE_CONFIG_DIR/data"
if [ ! -d "$EXTENSIONS_DIR" ]; then
    mkdir "$EXTENSIONS_DIR" || { echo "Error creating $EXTENSIONS_DIR"; exit 1; }
fi
if [ ! -d "$DATA_DIR" ]; then
    mkdir "$DATA_DIR" || { echo "Error creating $DATA_DIR"; exit 1; }
fi
if [ ! -d "$BASE_DIR/OmniGibson" ]; then
    git clone https://github.com/StanfordVL/OmniGibson.git $BASE_DIR/OmniGibson
    cd $BASE_DIR/OmniGibson
    git pull
    git checkout vscode-docker  # TODO: Change this to og-develop before vscode-docker is merged
    cd $BASE_DIR
fi
WEBRTC_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')
HTTP_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')
VSCODE_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')
while [ "$HTTP_PORT" -eq "$WEBRTC_PORT" ]; do
    HTTP_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')
done
while [ "$VSCODE_PORT" -eq "$WEBRTC_PORT" ] || [ "$VSCODE_PORT" -eq "$HTTP_PORT" ]; do
    VSCODE_PORT=$(python -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1])')
done
FQDN_HOSTNAME=$(hostname -i)  # $(curl "https://checkip.amazonaws.com")
echo "[OMNIGIBSON-VSCODE] Launching remote OmniGibson environment..."
echo "[OMNIGIBSON-VSCODE] To access vscode, go to http://${FQDN_HOSTNAME}:${VSCODE_PORT}"
echo "[OMNIGIBSON-VSCODE] To access webrtc, go to http://${FQDN_HOSTNAME}:${HTTP_PORT}/streaming/webrtc-client"
echo ""
IMAGE_PATH="/cvgl/group/Gibson/og-docker/omnigibson-vscode.sqsh"
GPU_ID=$(nvidia-smi -L | grep -oP '(?<=GPU-)[a-fA-F0-9\-]+' | head -n 1)
ISAAC_CACHE_PATH="/scr-ssd/${SLURM_JOB_USER}/isaac_cache_${GPU_ID}"
declare -A ENVS=(
    [NVIDIA_DRIVER_CAPABILITIES]=all
    [NVIDIA_VISIBLE_DEVICES]=0
    [DISPLAY]=""
    [OMNIGIBSON_REMOTE_STREAMING]="webrtc"
    [OMNIGIBSON_HTTP_PORT]=${HTTP_PORT}
    [OMNIGIBSON_WEBRTC_PORT]=${WEBRTC_PORT}
    [OMNIGIBSON_VSCODE_PORT]=${VSCODE_PORT}
    [PASSWORD]=${USERNAME}
)
for env_var in "${!ENVS[@]}"; do
    # Add to env kwargs we'll pass to enroot command later
    ENV_KWARGS="${ENV_KWARGS} --env ${env_var}=${ENVS[${env_var}]}"
done
declare -A MOUNTS=(
    [/scr-ssd/og-data-0-2-1]=/data
    [${ISAAC_CACHE_PATH}/isaac-sim/kit/cache/Kit]=/isaac-sim/kit/cache/Kit
    [${ISAAC_CACHE_PATH}/isaac-sim/cache/ov]=/root/.cache/ov
    [${ISAAC_CACHE_PATH}/isaac-sim/cache/pip]=/root/.cache/pip
    [${ISAAC_CACHE_PATH}/isaac-sim/cache/glcache]=/root/.cache/nvidia/GLCache
    [${ISAAC_CACHE_PATH}/isaac-sim/cache/computecache]=/root/.nv/ComputeCache
    [${ISAAC_CACHE_PATH}/isaac-sim/logs]=/root/.nvidia-omniverse/logs
    [${ISAAC_CACHE_PATH}/isaac-sim/config]=/root/.nvidia-omniverse/config
    [${ISAAC_CACHE_PATH}/isaac-sim/data]=/root/.local/share/ov/data
    [${ISAAC_CACHE_PATH}/isaac-sim/documents]=/root/Documents
    [${BASE_DIR}/OmniGibson]=/omnigibson-src
    [${VSCODE_CONFIG_DIR}]=/vscode-config
)
MOUNT_KWARGS=""
for mount in "${!MOUNTS[@]}"; do
    # Verify mount path in local directory exists, otherwise, create it
    if [ ! -e "$mount" ]; then
        mkdir -p ${mount}
    fi
    # Add to mount kwargs we'll pass to enroot command later
    MOUNT_KWARGS="${MOUNT_KWARGS} --mount ${mount}:${MOUNTS[${mount}]}"
done
CONTAINER_NAME=omnigibson_${GPU_ID}
enroot create --force --name ${CONTAINER_NAME} ${IMAGE_PATH}
ENV_KWARGS="${ENV_KWARGS:1}"
MOUNT_KWARGS="${MOUNT_KWARGS:1}"
ENROOT_MOUNT_HOME=no enroot start \
    --root \
    --rw \
    ${ENV_KWARGS} \
    ${MOUNT_KWARGS} \
    ${CONTAINER_NAME}
enroot remove -f ${CONTAINER_NAME}
