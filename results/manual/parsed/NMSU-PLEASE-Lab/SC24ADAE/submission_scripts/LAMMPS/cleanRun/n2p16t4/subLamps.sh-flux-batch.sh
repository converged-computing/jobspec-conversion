#!/bin/bash
#FLUX: --job-name=lammps
#FLUX: -N=2
#FLUX: --exclusive
#FLUX: --queue=wholenode
#FLUX: -t=1800
#FLUX: --urgency=16

export OMP_NUM_THREADS='4 #$SLURM_CPUS_PER_TASK'
export OMP_PROC_BIND='spread'
export OMP_PLACES='cores'

module load gcc/11.2.0
module load openmpi/4.0.6
INPUT=in.ar.lj
EXEC=../../lmp_omp
export OMP_NUM_THREADS=4 #$SLURM_CPUS_PER_TASK
export OMP_PROC_BIND=spread
export OMP_PLACES=cores
time srun --ntasks-per-node=16 -c 8 --cpu-bind=cores ${EXEC} -sf omp -pk omp 4 -in ${INPUT}
