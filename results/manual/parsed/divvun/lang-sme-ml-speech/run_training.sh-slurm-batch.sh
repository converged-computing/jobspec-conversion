#!/bin/bash
#SBATCH --job-name=TestGPUOnSaga
#SBATCH --account=nn9866k
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=11:50:00

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/cluster/projects/nn9866k/extra/lib'

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
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/cluster/projects/nn9866k/extra/lib
RET=1
until [[ ${RET} -eq 0 ]]; do
	python train_forward.py 
	RET=$?
	sleep 1
done
kill -SIGINT "$NVIDIA_MONITOR_PID"
