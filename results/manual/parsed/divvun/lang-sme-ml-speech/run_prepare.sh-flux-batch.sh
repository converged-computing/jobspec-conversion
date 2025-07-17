#!/bin/bash
#FLUX: --job-name=TestGPUOnSaga
#FLUX: --queue=accel
#FLUX: -t=300
#FLUX: --urgency=16

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge  # Reset the modules to the system default
module load PyTorch/1.4.0-fosscuda-2019b-Python-3.7.4
module unload PyTorch/1.4.0-fosscuda-2019b-Python-3.7.4
module list
source $SLURM_SUBMIT_DIR/env/bin/activate
nvidia-smi --query-gpu=timestamp,utilization.gpu,utilization.memory \
	--format=csv --loop=1 > "gpu_util-$SLURM_JOB_ID.csv" &
NVIDIA_MONITOR_PID=$!  # Capture PID of monitoring process
python train_tacotron.py --force_align
kill -SIGINT "$NVIDIA_MONITOR_PID"
