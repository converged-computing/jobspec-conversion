#!/bin/bash
#FLUX: --job-name=cowy-pancake-4515
#FLUX: --exclusive
#FLUX: --priority=16

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
