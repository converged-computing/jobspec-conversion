#!/bin/bash
#SBATCH --nodes=2
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:2
#SBATCH --mem=32G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=2

export WORLD_SIZE='4  # Total number of GPUs across all nodes'
export NODE_RANK='$SLURM_NODEID'
export RANK='$SLURM_PROCID'
export PYTHONFAULTHANDLER='1'

module purge
module load cesga/system miniconda3/22.11
eval "$(conda shell.bash hook)"
conda deactivate
source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
export WORLD_SIZE=4  # Total number of GPUs across all nodes
export NODE_RANK=$SLURM_NODEID
export RANK=$SLURM_PROCID
export PYTHONFAULTHANDLER=1
pythonint=$(which python)
srun python ddp.py
srun python dp.py
