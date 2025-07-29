#!/bin/bash
#SBATCH --job-name=BRT-EVL
#SBATCH --account=project_465000157
#SBATCH --output=report/%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=6
#SBATCH --gres=1
#SBATCH --mem=7G
#SBATCH --time=03:00:00

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
