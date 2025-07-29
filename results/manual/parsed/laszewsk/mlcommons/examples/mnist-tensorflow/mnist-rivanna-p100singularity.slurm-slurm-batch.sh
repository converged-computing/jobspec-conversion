#!/bin/bash
#SBATCH --job-name=mnist
#SBATCH --account=bii_dsc
#SBATCH --output=mnist-p100.out
#SBATCH --error=mnist-p100.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:p100:1
#SBATCH --time=00:01:00
#SBATCH --partition=gpu

module purge
module load singularity
module load anaconda
source activate py3.10
python -V
PYTHON=`which python`
lscpu
nvidia-smi
workdir=/scratch/$USER/rivanna
time singularity run --nv $workdir/tensorflow-2.7.0.sif mnist.py
