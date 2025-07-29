#!/bin/bash
#SBATCH --output=./stdout/%x_%j.out
#SBATCH --mail-user=wayne.weiqiang@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=21
#SBATCH --cpus-per-task=1
#SBATCH --time=7-00:00:00
#SBATCH --partition=serc

export MPI_C_LIBRARIES='/share/software/user/open/openmpi/4.0.3/lib/libmpi.so'
export MPI_INCLUDE_PATH='/share/software/user/open/openmpi/4.0.3/include'

module -q purge
module load openmpi/4.0.3
export MPI_C_LIBRARIES=/share/software/user/open/openmpi/4.0.3/lib/libmpi.so
export MPI_INCLUDE_PATH=/share/software/user/open/openmpi/4.0.3/include
mpirun -n 21 julia $SLURM_JOB_NAME
