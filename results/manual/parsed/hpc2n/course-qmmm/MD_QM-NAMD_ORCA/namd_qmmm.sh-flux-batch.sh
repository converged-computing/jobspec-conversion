#!/bin/bash
#FLUX: --job-name=qmmm
#FLUX: -n=14
#FLUX: -t=1800
#FLUX: --urgency=16

ml purge  > /dev/null 2>&1 
ml GCC/10.3.0  OpenMPI/4.1.1
ml NAMD/2.14-nompi
ml ORCA/5.0.1
namd2 +p4 QMMM-Min.conf   > output_minimization.dat
