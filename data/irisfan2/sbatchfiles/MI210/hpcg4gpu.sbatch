#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks-per-node=4
#SBATCH --cpus-per-task=8
#SBATCH --mem=64GB
#SBATCH --gres=gpu:4
#SBATCH -o %x-%N-%j.out
#SBATCH -e %x-%N-%j.err

source /etc/profile.d/modules.sh
module load rocm/5.2.3

tmp=/tmp/$USER/hpcg4-$$
mkdir -p $tmp

singularity run /shared/apps/bin/rochpcg_3.1.amd1_21.sif mpirun --mca pml ucx -np 4 rochpcg 336 168 672 1860

rm -rf /tmp/$USER/hpcg4-$$

