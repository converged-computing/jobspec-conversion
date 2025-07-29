#!/bin/bash
#FLUX: --job-name=plumed
#FLUX: --queue=jobs
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel
module load intel-mkl
module load intel-mpi
module load lammps
LAMMPS=lmp_mpi
cd example_natasha
srun --time=24:00:00 --hint=nomultithread --exclusive -n ${SLURM_NTASKS} ${LAMMPS} -i in.lmp > log.lammps
