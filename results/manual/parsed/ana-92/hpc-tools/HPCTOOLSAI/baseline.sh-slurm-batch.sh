#!/bin/bash
#SBATCH --job-name=baseline
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:a100:1
#SBATCH --mem=32G
#SBATCH --time=00:10:00
#SBATCH --constraint=ntasks-per-node=1

export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module purge
module load cesga/system miniconda3/22.11
eval "$(conda shell.bash hook)"
conda deactivate
source $STORE/mytorchdist/bin/deactivate
source $STORE/mytorchdist/bin/activate
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
which python
srun python baseline.py
