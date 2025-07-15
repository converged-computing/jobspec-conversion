#!/bin/bash
#FLUX: --job-name=qb_04vs_demo_60f-1w_naive-fine
#FLUX: -n=2
#FLUX: -c=4
#FLUX: -t=1800
#FLUX: --priority=16

export RUST_LOG='debug'

set -e
RUN_BASE_DIRECTORY="$HOME/diploma/distributed-rendering-diploma"
LOGS_DIRECTORY="/d/hpc/projects/FRI/sg7710/distributed-rendering-logs/logs"
LOG_NAME="qb_04vs_demo_60f-1w_naive-fine"
BLENDER_PROJECT_DIRECTORY="$RUN_BASE_DIRECTORY/blender-projects/04_very-simple"
JOB_FILE_PATH="$BLENDER_PROJECT_DIRECTORY/04_very-simple_demo_60f-1w.toml"
RESULTS_DIRECTORY="$BLENDER_PROJECT_DIRECTORY/results"
SERVER_PORT=9901
WORKER_AMOUNT=20
FORMATTED_CURRENT_DATE_TIME=$(date +%Y-%m-%d_%H-%M-%S)
MASTER_LOG_FILE_PATH="$LOGS_DIRECTORY/$FORMATTED_CURRENT_DATE_TIME.$LOG_NAME.master.log"
WORKERS_LOG_FILE_PATH="$LOGS_DIRECTORY/$FORMATTED_CURRENT_DATE_TIME.$LOG_NAME.workers.log"
cd ~/diploma/distributed-rendering-diploma
export RUST_LOG=debug
SERVER_NODE_HOSTNAME=$(hostname -s)
echo "[Batching] Hostname of server will be $SERVER_NODE_HOSTNAME."
echo "[Batching] Starting master server."
srun --job-name="master" --nodelist="$SERVER_NODE_HOSTNAME" --ntasks=1 --output="$MASTER_LOG_FILE_PATH" --cpu-bind=cores --exact "$RUN_BASE_DIRECTORY/target/release/master" --host "0.0.0.0" --port "$SERVER_PORT" run-job --resultsDirectory "$RESULTS_DIRECTORY" "$JOB_FILE_PATH" &
echo "[Batching] Starting workers (1 task)."
srun --job-name="workers" --ntasks="$WORKER_AMOUNT" --output="$WORKERS_LOG_FILE_PATH" --cpu-bind=cores --exact singularity exec --bind "$RUN_BASE_DIRECTORY/blender-projects" --env RUST_LOG="debug" "$RUN_BASE_DIRECTORY/blender-3.6.0.sif" "$RUN_BASE_DIRECTORY/target/release/worker" --masterServerHost "$SERVER_NODE_HOSTNAME" --masterServerPort "$SERVER_PORT" --baseDirectory "$RUN_BASE_DIRECTORY" --blenderBinary "/usr/bin/blender" &
wait
