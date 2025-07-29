#!/bin/bash
#SBATCH --mail-user=beck@ml.jku.at
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gres=gpu:3
#SBATCH --mem=200G
#SBATCH --partition=compute
#SBATCH --constraint=T4

export MKL_NUM_THREADS='$NUM_CORES OMP_NUM_THREADS=$NUM_CORES'

eval "$(conda shell.bash hook)"
conda activate subspaces
which python
NUM_CORES=32
export MKL_NUM_THREADS=$NUM_CORES OMP_NUM_THREADS=$NUM_CORES
python run_sweep.py --config-name 11.7.1_mnist_lenet_rotatedtasks.yaml
