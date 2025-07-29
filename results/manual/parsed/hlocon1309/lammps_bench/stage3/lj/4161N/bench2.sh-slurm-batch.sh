#!/bin/bash
#SBATCH --account=proj_1371
#SBATCH --nodes=4
#SBATCH --ntasks=16
#SBATCH --cpus-per-task=1
#SBATCH --constraint=type_b
#SBATCH --nodelist=cn-[017,018,020,022]

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022jun23_update1
srun --mpi=pmix_v2 lmp -i in.lj -sf gpu -pk gpu 1
