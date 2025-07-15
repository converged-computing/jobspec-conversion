#!/bin/bash
#FLUX: --job-name=joyous-staircase-7913
#FLUX: --urgency=16

module load lammps/2020/intel
bash run_dpd_water_mpi_helper.sh mpi_intel_n1_t40
