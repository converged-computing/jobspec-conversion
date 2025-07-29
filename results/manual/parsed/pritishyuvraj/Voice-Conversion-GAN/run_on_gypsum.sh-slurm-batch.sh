#!/bin/bash
#SBATCH --job-name=1-gpu-bidaf-pytorch
#SBATCH --output=bidaf-pytorch-%A.out
#SBATCH --error=bidaf-pytorch-%A.err
#SBATCH --mail-user=pyuvraj@cs.umass.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1

echo $SLURM_JOBID - `hostname` >> ~/slurm-jobs.txt
module purge
module load python/3.6.1
module load cuda80/blas/8.0.44
module load cuda80/fft/8.0.44
module load cuda80/nsight/8.0.44
module load cuda80/profiler/8.0.44
module load cuda80/toolkit/8.0.44
python -m train.py
