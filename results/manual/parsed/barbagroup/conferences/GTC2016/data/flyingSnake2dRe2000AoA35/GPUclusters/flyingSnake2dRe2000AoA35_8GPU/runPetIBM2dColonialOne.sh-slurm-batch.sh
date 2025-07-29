#!/bin/bash
#FLUX: --job-name=2k35bcgs
#FLUX: -n=32
#FLUX: --queue=short
#FLUX: -t=172800
#FLUX: --urgency=16

OPENMPI_DIR="/c1/apps/openmpi/1.8/gcc/4.9.2"
MPIRUN="$OPENMPI_DIR/bin/mpirun"
PETIBM_BUILD="$HOME/builds/petibm-0.1_petsc-3.5.2_openmpi-1.8_gcc-4.9.2_opt"
PETIBM2D="$PETIBM_BUILD/bin/petibm2d"
time $MPIRUN $PETIBM2D -directory $PWD -log_summary
