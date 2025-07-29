#!/bin/bash
#SBATCH --job-name=XLSum
#SBATCH --output=xlsum_four_node_eight_gpu.log
#SBATCH --nodes=4
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:p100:2
#SBATCH --mem-per-cpu=32G
#SBATCH --time=7-00:00:00

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
