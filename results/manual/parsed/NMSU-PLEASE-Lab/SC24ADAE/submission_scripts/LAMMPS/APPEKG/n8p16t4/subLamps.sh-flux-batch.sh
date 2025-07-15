#!/bin/bash
#FLUX: --job-name=LAMMPSAPPEKG
#FLUX: -N=8
#FLUX: --exclusive
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='4'
export OMP_PLACES='cores'
export OMP_PROC_BIND='spread'

echo "good run"
module load gcc/11.2.0
module load openmpi/4.0.6
INPUT=in.ar.lj
EXEC=../../lmp_omp_appekg
export OMP_NUM_THREADS=4
export OMP_PLACES=cores
export OMP_PROC_BIND=spread
time srun --ntasks-per-node=16 --cpus-per-task=8 --cpu-bind=cores ${EXEC} -sf omp -pk omp 4 -in ${INPUT}
