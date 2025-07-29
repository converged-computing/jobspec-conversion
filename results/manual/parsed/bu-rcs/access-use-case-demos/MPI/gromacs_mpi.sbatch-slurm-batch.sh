#!/bin/bash
#FLUX: --job-name=gmx_mpi_test
#FLUX: -N=2
#FLUX: -n=96
#FLUX: --queue=skx
#FLUX: -t=86400
#FLUX: --urgency=16

module load intel/24.0
module load impi/21.11
module load gromacs/2023.3
ibrun gmx_mpi pdb2gmx -f 1AKI_clean.pdb -o 1AKI_processed.gro -water spce -ff oplsaa
