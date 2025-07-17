#!/bin/bash
#FLUX: --job-name=hello-pedo-0396
#FLUX: -n=4
#FLUX: --queue=GPU
#FLUX: --urgency=16

SINGULARITYENV_LD_LIBRARY_PATH=/opt/openmpi/lib
SINGULARITYENV_PREPEND_PATH=/opt/openmpi/bin
mpiexec -n 4 singularity exec -B /opt/openmpi ~/centos7.sif ~/mpitest
echo $?
