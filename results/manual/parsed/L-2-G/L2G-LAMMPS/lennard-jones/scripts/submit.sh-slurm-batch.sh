#!/bin/bash
#SBATCH --job-name=learningToGrow
#SBATCH --account=m1759
#SBATCH --output=l2g.out
#SBATCH --nodes=1
#SBATCH --ntasks=40
#SBATCH --cpus-per-task=2
#SBATCH --time=00:10:00
#SBATCH --exclusive
#SBATCH --constraint=gpu

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
