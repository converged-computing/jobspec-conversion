#!/bin/bash
#SBATCH --account=hpc_build
#SBATCH --output=gpuTest_%A.out
#SBATCH --error=gpuTest_%A.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:4
#SBATCH --mem=60000
#SBATCH --time=04:00:00
#SBATCH --constraint=ntasks-per-node=4

echo 'slurm allocates gpus ' $CUDA_VISIBLE_DEVICES
module load matlab/R2020a
ndim=12000;
nloop=1000;
 matlab -nodisplay -r  \
  "gpuTest1(${ndim},${nloop},'${SLURM_JOB_ID}');exit;"
