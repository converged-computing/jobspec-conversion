#!/bin/bash
#SBATCH --job-name=tensorflow_gpu
#SBATCH --account=glab
#SBATCH --mail-user=pg2328@columbia.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=1-17:59:00

module load intel-parallel-studio/2017
module load cuda80/toolkit cuda80/blas cudnn/5.1 
module load anaconda/2-4.2.0 
mpiexec python ./main.py --batch_size=4096 --dataset='SPDQ' --hidden='5' # > atoutfile
date
