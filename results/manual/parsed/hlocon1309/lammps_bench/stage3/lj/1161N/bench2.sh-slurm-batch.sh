#!/bin/bash
#SBATCH --account=proj_1371
#SBATCH --nodes=1
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --gres=2
#SBATCH --partition=normal
#SBATCH --constraint=type_a
#SBATCH --nodelist=cn-[016]

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022jun23_update1
srun --mpi=pmix_v2 lmp -i in.lj -sf gpu -pk gpu 2
