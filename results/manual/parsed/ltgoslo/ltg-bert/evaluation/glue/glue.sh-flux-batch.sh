#!/bin/bash
#FLUX: --job-name=BRT-EVL
#FLUX: -c=6
#FLUX: --queue=pilot
#FLUX: -t=10800
#FLUX: --urgency=16

export PS1='\$'
export NCCL_SOCKET_IFNAME='hsn'
export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OPENBLAS_VERBOSE='2'
export PYTHONUSERBASE='/projappl/project_465000157/.local'
export PATH='$PYTHONUSERBASE/bin:$PATH'
export PYTHONPATH='$PYTHONUSERBASE/lib/python3.9/site-packages:$PYTHONPATH'
export WANDB_MODE='offline'

set -o errexit  # Exit the script on any error
set -o nounset  # Treat any unset variables as an error
module --quiet purge
module load LUMI/22.08
module load cray-python/3.9.12.1
module load rocm/5.0.2
export PS1=\$
export NCCL_SOCKET_IFNAME=hsn
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OPENBLAS_VERBOSE=2
export PYTHONUSERBASE='/projappl/project_465000157/.local'
export PATH=$PYTHONUSERBASE/bin:$PATH
export PYTHONPATH=$PYTHONUSERBASE/lib/python3.9/site-packages:$PYTHONPATH
export WANDB_MODE=offline
CHECKPOINT_PATH=$1
TASK=$2
BATCH_SIZE=$3
EPOCHS=$4
GLUE_PATH="data/extrinsic/glue"
python3 glue.py --task ${TASK} --batch_size ${BATCH_SIZE} --epochs ${EPOCHS} --input_dir ${GLUE_PATH} --checkpoint_path ${CHECKPOINT_PATH} || exit 1
