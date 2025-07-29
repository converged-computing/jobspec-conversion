#!/bin/bash
#FLUX: --job-name=XLSum
#FLUX: -N=4
#FLUX: -n=4
#FLUX: -c=2
#FLUX: -t=604800
#FLUX: --urgency=16

export NCCL_DEBUG='INFO'
export NPROC_PER_NODE='2  '
export PARENT='`/bin/hostname -s`'
export MPORT='12345'
export CHILDREN='`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $PARENT`'
export HOSTLIST='$PARENT $CHILDREN'
export WORLD_SIZE='$SLURM_NTASKS'
export BASE_DIR='$(pwd)'

module load gcc/7.3.0
module load openmpi/3.0.0
module load anaconda3/5.1.0
module load cuda/10.2.89
module load cudnn/7.6.5-cuda-10.2.89
module load nccl/2.6.4
module load python/3.7.4
module load git/2.18.0
export NCCL_DEBUG=INFO
export NPROC_PER_NODE=2  
export PARENT=`/bin/hostname -s`
export MPORT=12345
export CHILDREN=`scontrol show hostnames $SLURM_JOB_NODELIST | grep -v $PARENT`
export HOSTLIST="$PARENT $CHILDREN"
export WORLD_SIZE=$SLURM_NTASKS
export BASE_DIR=$(pwd)
source activate "${BASE_DIR}/env"
srun "${BASE_DIR}/distributed_trainer.sh"
