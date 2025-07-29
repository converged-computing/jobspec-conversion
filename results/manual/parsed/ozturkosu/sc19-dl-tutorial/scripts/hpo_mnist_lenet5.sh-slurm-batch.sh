#!/bin/bash
#SBATCH --job-name=hpo-mnist-lenet5
#SBATCH --output=logs/%x-%j.out
#SBATCH --nodes=4
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=debug
#SBATCH --constraint=knl

module load tensorflow/intel-1.13.1-py36
module load cray-hpo
script=genetic.py
args="-N ${SLURM_JOB_NUM_NODES} --verbose"
path=hpo/mnist-lenet5
cd $path && python $script $args
