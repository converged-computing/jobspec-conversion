#!/bin/bash
#FLUX: --job-name=qb_04vs_14400f-80w_dynamic
#FLUX: -n=81
#FLUX: -c=4
#FLUX: -t=7200
#FLUX: --priority=16

export RUST_LOG='debug'

set -e
RUN_BASE_DIRECTORY="$HOME/diploma/distributed-rendering-diploma"
LOGS_DIRECTORY="/d/hpc/projects/FRI/sg7710/distributed-rendering-logs/logs"
LOG_NAME="qb_04vs_14400f-80w_dynamic"
BLENDER_PROJECT_DIRECTORY="$RUN_BASE_DIRECTORY/blender-projects/04_very-simple"
JOB_FILE_PATH="$BLENDER_PROJECT_DIRECTORY/04_very-simple_measuring_14400f-80w_dynamic.toml"
RESULTS_DIRECTORY="$BLENDER_PROJECT_DIRECTORY/results"
SERVER_PORT=9952
FORMATTED_CURRENT_DATE_TIME=$(date +%Y-%m-%d_%H-%M-%S)
JOB_LOG_DIRECTORY_PATH="$LOGS_DIRECTORY/$FORMATTED_CURRENT_DATE_TIME.$LOG_NAME"
mkdir -p "$JOB_LOG_DIRECTORY_PATH"
cd ~/diploma/distributed-rendering-diploma
export RUST_LOG=debug
SERVER_NODE_HOSTNAME=$(hostname -s)
echo "[Batching] Hostname of server will be $SERVER_NODE_HOSTNAME."
echo "[Batching] Starting master server on $SERVER_NODE_HOSTNAME."
srun --job-name="master" --nodelist="$SERVER_NODE_HOSTNAME" --ntasks=1 --nodes=1 --output="$JOB_LOG_DIRECTORY_PATH/$LOG_NAME.slurm.master.log" --cpu-bind=cores --exact "$RUN_BASE_DIRECTORY/target/release/master" --host "0.0.0.0" --port "$SERVER_PORT" --logFilePath "$JOB_LOG_DIRECTORY_PATH/$LOG_NAME.master.log" run-job --resultsDirectory "$RESULTS_DIRECTORY" "$JOB_FILE_PATH" &
sleep 4
echo "[Batching] Starting workers (80 tasks)."
for i in {1..80}; do
  echo "[Batching] Starting worker $i."
  srun --job-name="worker.$i" --ntasks=1 --nodes=1 --output="$JOB_LOG_DIRECTORY_PATH/$LOG_NAME.slurm.worker.$i.log" --cpu-bind=cores --exact singularity exec --bind "$RUN_BASE_DIRECTORY/blender-projects" --env RUST_LOG="debug" "$RUN_BASE_DIRECTORY/blender-3.6.0.sif" "$RUN_BASE_DIRECTORY/target/release/worker" --logFilePath "$JOB_LOG_DIRECTORY_PATH/$LOG_NAME.worker.$i.log" --masterServerHost "$SERVER_NODE_HOSTNAME" --masterServerPort "$SERVER_PORT" --baseDirectory "$RUN_BASE_DIRECTORY" --blenderBinary "/usr/bin/blender" &
  sleep 1
done
echo "[Batching] All workers started, waiting for all steps to complete."
wait
