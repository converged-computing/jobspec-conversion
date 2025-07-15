#!/bin/bash
#FLUX: --job-name=ondemand/sys/myjobs/basic_gromacs_parallel
#FLUX: -t=1800
#FLUX: --urgency=16

set +vx
module unload mvapich2
module unload intel
module load intel/18.0.3
module load mvapich2/2.3
module load gromacs/2018.2
module list
set -vx
sbcast -p /users/appl/srb/workshops/compchem/gromacs/md01.tpr $TMPDIR
cd $TMPDIR
gmx mdrun -deffnm md01
cat md01.log
cp -p * $SLURM_SUBMIT_DIR/
ls -al
