#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:10:00
#SBATCH --partition=dev_q
#SBATCH --constraint=ntasks-per-node=16

module reset
module load MATLAB
matlab -batch prime_batch_local
exit 0
