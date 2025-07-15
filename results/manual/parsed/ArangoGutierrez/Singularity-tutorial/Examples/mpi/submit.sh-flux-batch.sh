#!/bin/bash
#FLUX: --job-name=confused-soup-6874
#FLUX: --urgency=16

SINGULARITYENV_LD_LIBRARY_PATH=/opt/openmpi/lib
SINGULARITYENV_PREPEND_PATH=/opt/openmpi/bin
mpiexec -n 4 singularity exec -B /opt/openmpi ~/centos7.sif ~/mpitest
echo $?
