#!/bin/bash
#SBATCH --job-name=feots_integrate
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1

export OMP_NUM_THREADS='8'

module purge
module load gcc openmpi
export OMP_NUM_THREADS=8
cd /home/${USER}/FEOTS/examples/gulfstream_dye/
date
mpirun -np 3 -x OMP_NUM_THREADS ./FEOTSDriver
date
