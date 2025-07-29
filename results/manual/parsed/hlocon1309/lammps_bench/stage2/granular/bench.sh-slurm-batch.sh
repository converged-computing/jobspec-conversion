#!/bin/bash
#SBATCH --account=proj_1371
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=00:30:00
#SBATCH --partition=normal
#SBATCH --constraint=type_a

module load openmpi/4.1.4
module load CUDA/11.7
module load lammps/2022sep15_cpu
srun --mpi=pmix_v2 lmp -i in.granular
