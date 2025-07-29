#!/bin/bash
#SBATCH --output=%x-%N-%j.out
#SBATCH --error=%x-%N-%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:2
#SBATCH --mem=64GB
#SBATCH --constraint=ntasks-per-node=2

source /etc/profile.d/modules.sh
module load rocm/5.2.3
tmp=/tmp/$USER/hpcg2-$$
mkdir -p $tmp
singularity run /shared/apps/bin/rochpcg_3.1.amd1_21.sif mpirun --mca pml ucx -np 2 rochpcg 336 168 672 1860
rm -rf /tmp/$USER/hpcg2-$$
