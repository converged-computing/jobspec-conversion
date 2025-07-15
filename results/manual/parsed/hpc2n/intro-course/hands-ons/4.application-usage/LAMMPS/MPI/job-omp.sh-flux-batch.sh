#!/bin/bash
#FLUX: --job-name=hairy-hope-2685
#FLUX: --urgency=16

export OMP_NUM_THREADS='2'

ml purge > /dev/null 2>&1
ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos 
export OMP_NUM_THREADS=2
srun lmp -in step4.1_equilibration.inp
