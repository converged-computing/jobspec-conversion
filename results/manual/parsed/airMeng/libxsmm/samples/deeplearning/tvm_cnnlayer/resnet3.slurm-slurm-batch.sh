#!/bin/bash
#SBATCH --job-name=resnet3
#SBATCH --output=resnet3.out
#SBATCH --mail-user=anand.venkat@intel.com
#SBATCH --mail-type=END,FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=112
#SBATCH --time=1-00:00:00
#SBATCH --partition=clx

export KMP_AFFINITY='granularity=fine,compact,1,28'
export OMP_NUM_THREADS='28'
export TVM_NUM_THREADS='28'

export KMP_AFFINITY=granularity=fine,compact,1,28
export OMP_NUM_THREADS=28
export TVM_NUM_THREADS=28
LD_PRELOAD=./libxsmm_wrapper/libxsmm_wrapper.so srun python -u mb1_tuned_latest.py -d resnet3
