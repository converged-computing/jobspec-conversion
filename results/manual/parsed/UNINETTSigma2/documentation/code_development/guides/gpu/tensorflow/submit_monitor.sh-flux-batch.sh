#!/bin/bash
#FLUX: --job-name=TestGPUOnSaga
#FLUX: --queue=accel
#FLUX: -t=300
#FLUX: --priority=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load TensorFlow/2.6.0-foss-2021a-CUDA-11.3.1
module list
nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory \
	--format=csv --loop=1 > "gpu_util-$SLURM_JOB_ID.csv" &
NVIDIA_MONITOR_PID=$!  # Capture PID of monitoring process
python gpu_intro.py
kill -SIGINT "$NVIDIA_MONITOR_PID"
