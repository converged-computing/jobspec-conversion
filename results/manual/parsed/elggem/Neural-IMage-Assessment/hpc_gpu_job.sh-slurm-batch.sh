#!/bin/bash
#SBATCH --job-name=nima-pqd
#SBATCH --output=./hpc_output_pqd.log
#SBATCH --mail-user=mayet@campus.tu-berlin.de
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:tesla:1
#SBATCH --time=09:00:00
#SBATCH --chdir=.

source ~/miniconda3/bin/activate base
module load nvidia/cuda/10.1
./train.sh $1 | tee > hpc_job_$1.log
