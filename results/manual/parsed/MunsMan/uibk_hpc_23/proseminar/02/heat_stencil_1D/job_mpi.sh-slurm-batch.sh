#!/bin/bash
#SBATCH --job-name=heat-mpi
#SBATCH --output=output.log
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --exclusive

module load openmpi/4.1.4-oneapi-2022.2.1-oj6kipv
mpirun -np $SLURM_NTASKS --mca btl_openib_allow_ib 1 ~/a.out 16384
