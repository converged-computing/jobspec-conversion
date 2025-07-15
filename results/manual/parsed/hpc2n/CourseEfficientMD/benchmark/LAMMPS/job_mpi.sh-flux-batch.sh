#!/bin/bash
#FLUX: --job-name=grated-toaster-7252
#FLUX: --priority=16

ml GCC/8.3.0  OpenMPI/3.1.4
ml LAMMPS/3Mar2020-Python-3.7.4-kokkos
srun lmp -in step4.1_equilibration.inp
