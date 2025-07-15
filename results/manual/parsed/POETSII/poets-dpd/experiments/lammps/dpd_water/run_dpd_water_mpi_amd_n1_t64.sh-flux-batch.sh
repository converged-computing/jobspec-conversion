#!/bin/bash
#FLUX: --job-name=lovable-bits-1948
#FLUX: --queue=amd
#FLUX: --urgency=16

module load openmpi/4.1.1/amd-intel
module load lammps/2020/amd-intel
which lmp
bash run_dpd_water_mpi_helper.sh mpi_amd_n1_t64
