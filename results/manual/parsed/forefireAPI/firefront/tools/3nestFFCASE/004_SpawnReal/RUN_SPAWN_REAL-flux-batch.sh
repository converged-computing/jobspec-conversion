#!/bin/bash
#FLUX: --job-name=FCAST_SPA1
#FLUX: --queue=intel
#FLUX: -t=36000
#FLUX: --urgency=16

export MPIRUN='mpirun -np 20'

continue_cycle=${1}
echo "SCRIPT SPAWN_MESONH " ${XYZ} " EN COURS"
ulimit -c 0
ulimit -s unlimited
. ~/runMNH 
ln -sf ../001_pgd/PGD_D*A.nested.* .
ln -sf ../003_run/RUN12.1.PRUN1.* .
export MPIRUN="mpirun -np 1"
time ${MPIRUN} SPAWNING${XYZ}
export MPIRUN="mpirun -np 20"
time ${MPIRUN} PREP_REAL_CASE${XYZ}
