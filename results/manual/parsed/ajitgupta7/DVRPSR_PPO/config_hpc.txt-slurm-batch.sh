#!/bin/bash
#SBATCH --job-name=DVRPSR20
#SBATCH --account=thes1501
#SBATCH --output=output.%J.txt
#SBATCH --nodes=2
#SBATCH --ntasks=4
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem-per-cpu=16G
#SBATCH --time=1-00:00:00
#SBATCH --constraint=ntasks-per-node=4

export CONDA_ROOT='$HOME/miniconda3'
export PATH='$CONDA_ROOT/bin:$PATH'

module load GCCcore/.12.2.0
module load Python/3.10.8
module load cuDNN/8.6.0.163-CUDA-11.8.0
export CONDA_ROOT=$HOME/miniconda3
. $CONDA_ROOT/etc/profile.d/conda.sh
export PATH="$CONDA_ROOT/bin:$PATH"
conda activate base
python run_model.py
