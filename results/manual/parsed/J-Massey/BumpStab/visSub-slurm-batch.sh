#!/bin/bash
#SBATCH --output=paraview.out
#SBATCH --error=paraview.out
#SBATCH --nodes=1
#SBATCH --ntasks=64
#SBATCH --cpus-per-task=1
#SBATCH --time=03:50:00

module purge
module load conda
source activate an
module load paraview/5.11
mpiexec -n $SLURM_NPROCS pvserver --connect-id=11111 --displays=0
