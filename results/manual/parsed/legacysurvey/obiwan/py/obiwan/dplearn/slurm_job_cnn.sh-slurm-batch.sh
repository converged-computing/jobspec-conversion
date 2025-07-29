#!/bin/bash
#SBATCH --job-name=tf
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:05:00
#SBATCH --constraint=knl,quad,cache

export OMP_NUM_THREADS='68'
export KMP_AFFINITY='granularity=fine,verbose,compact,1,0'
export KMP_SETTINGS='1'
export KMP_BLOCKTIME='1'
export isKNL='yes'

module load tensorflow/intel-head
export OMP_NUM_THREADS=68
export KMP_AFFINITY="granularity=fine,verbose,compact,1,0"
export KMP_SETTINGS=1
export KMP_BLOCKTIME=1
export isKNL=yes
date
srun -n 68 -c 1 --cpu_bind=cores python cnn.py
date
