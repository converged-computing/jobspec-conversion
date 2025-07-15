#!/bin/bash
#FLUX: --job-name=naca-0012-34
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --priority=16

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
cd run/naca-Re-1.5-Ma-0.85-fine
./Allrun 16
