#!/bin/bash
#FLUX: --job-name=learningToGrow
#FLUX: -n=40
#FLUX: -c=2
#FLUX: --exclusive
#FLUX: --queue=regular
#FLUX: -t=600
#FLUX: --urgency=16

export LAMMPS_DIR='$HOME'
export OMP_NUM_THREADS='1'

HOME="$(pwd)"
module purge 
module load cgpu
module load cmake 
module load PrgEnv-llvm/12.0.0-git_20210117
module load python
export LAMMPS_DIR=$HOME
export OMP_NUM_THREADS=1
date
python3.8 $HOME/scripts/run_l2g.py -gpus 8
date
