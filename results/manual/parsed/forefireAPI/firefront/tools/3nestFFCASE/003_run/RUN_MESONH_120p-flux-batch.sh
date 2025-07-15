#!/bin/bash
#FLUX: --job-name=reclusive-kerfuffle-3335
#FLUX: --queue=intel
#FLUX: -t=36000
#FLUX: --priority=16

export MPIRUN='mpirun -np 120'

continue_cycle=${1}
echo "SCRIPT RUN_MESONH " ${XYZ} " EN COURS"
ulimit -c 0
ulimit -s unlimited
. ~/runMNH 
ln -sf ../001_pgd/PGD_*nested.* .
ln -sf ../002_real/M1* .
export MPIRUN="mpirun -np 120"
time ${MPIRUN} MESONH${XYZ}
mv OUTPUT_LISTING0  OUTPUT_LISTING0_run1
mv OUTPUT_LISTING1  OUTPUT_LISTING1_run1
