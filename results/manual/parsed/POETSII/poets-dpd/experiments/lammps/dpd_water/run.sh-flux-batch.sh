#!/bin/bash
#FLUX: --job-name=scruptious-poodle-3063
#FLUX: --urgency=16

module load lammps/2020/intel
mpiexec -np $SLURM_NTASKS lmp -in dpd_water_100x100x100_t1000.txt
