#!/bin/bash
#SBATCH --job-name=diffae_autoenc
#SBATCH --output=output.log
#SBATCH --error=errors.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=04:00:00

export CONDA_ROOT='$HOME/anaconda3'
export PATH='$CONDA_ROOT/bin:$PATH'
export NCCL_DEBUG='INFO'
export PYTHONFAULTHANDLER='1'

module load CUDA
export CONDA_ROOT=$HOME/anaconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate diffautoenc
echo; export; echo; nvidia-smi; echo
export NCCL_DEBUG=INFO
export PYTHONFAULTHANDLER=1
srun python test_manipulate.py
