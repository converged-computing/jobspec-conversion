#!/bin/bash
#FLUX: --job-name=boopy-latke-6346
#FLUX: --urgency=16

module load lammps/2020/intel
bash run_dpd_water_mpi_helper.sh mpi_intel_n1_t40
