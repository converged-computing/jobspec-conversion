#!/bin/bash
#FLUX: --job-name=naca-0012-34
#FLUX: --queue=standard
#FLUX: -t=432000
#FLUX: --urgency=16

module load singularity/3.6.0rc2
module load mpi/openmpi/4.0.1/cuda_aware_gcc_6.3.0
mkdir -p run
cp -r test_cases/naca-Re-3-Ma-0.85-base run/
cd run/naca-Re-3-Ma-0.85-base
./Allrun 8
