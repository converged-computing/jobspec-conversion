#!/bin/bash
#FLUX: --job-name=byol
#FLUX: -c=12
#FLUX: -t=216000
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MASTER_ADDR='$(hostname -s)  # Store the master node’s IP address in the MASTER_ADDR environment variable.'
export MAIN_HOST='$MASTER_ADDR'

                                    # %x=job-name, %A=job ID, %a=array value, %n=node rank, %t=task rank, %N=hostname
                                    # Note: You must manually create output directory "logs" before launching job.
GPUS_PER_NODE=4
set -e
start_time="$SECONDS"
ENVNAME=ssl_env
source ~/venvs/ssl_env/bin/activate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MASTER_ADDR=$(hostname -s)  # Store the master node’s IP address in the MASTER_ADDR environment variable.
export MAIN_HOST="$MASTER_ADDR"
echo "r$SLURM_NODEID master: $MASTER_ADDR"
echo "r$SLURM_NODEID Launching python script"
source "./slurm/get_socket.sh"
source "./slurm/copy_and_extract_data.sh"
echo "EXTRA_ARGS = ${@}"
srun python ./solo_learn_train-bentho.py \
	--ssl_cfg "byol.cfg" \
	--method "byol" \
	--aug_stack_cfg "byol_aug_stack.cfg" \
	--nodes $SLURM_JOB_NUM_NODES \
	--gpus $GPUS_PER_NODE \
	--name "byol-100e" \
	"${@}"
