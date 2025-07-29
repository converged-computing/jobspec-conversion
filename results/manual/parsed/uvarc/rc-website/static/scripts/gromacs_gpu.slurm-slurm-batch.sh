#!/bin/bash
#SBATCH --account=mygroup
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=10:00:00
#SBATCH --partition=gpu
#SBATCH --constraint=ntasks-per-node=10

module purge
module load goolf/11.2.0_4.1.4 gromacs
srun gmx_mpi <arguments>
