#!/bin/bash
#FLUX: --job-name=ssl-bentho-mini
#FLUX: -N=2
#FLUX: -c=8
#FLUX: -t=10800
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(hostname -s)  # Store the master node’s IP address in the MASTER_ADDR environment variable.'
export MAIN_HOST='$MASTER_ADDR'

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must manually create output directory "logs" before launching job.
GPUS_PER_NODE=4
set -e
start_time="$SECONDS"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MASTER_ADDR=$(hostname -s)  # Store the master node’s IP address in the MASTER_ADDR environment variable.
export MAIN_HOST="$MASTER_ADDR"
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
source "./slurm/get_socket.sh"
echo "EXTRA_ARGS = ${@}"
srun python ./solo_learn_train-bentho.py \
	--mini True \
	--ssl_cfg "mae.cfg" \
	--method "mae" \
	--aug_stack_cfg "mae_aug_stack.cfg" \
	--nodes $SLURM_JOB_NUM_NODES \
	--gpus $GPUS_PER_NODE \
	--name "mae-testing" \
	"${@}"
