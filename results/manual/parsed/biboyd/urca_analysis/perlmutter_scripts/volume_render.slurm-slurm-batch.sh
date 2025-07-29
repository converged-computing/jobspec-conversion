#!/bin/bash
#SBATCH --account=m3018
#SBATCH --mail-user=boyd.brendan@stonybrook.edu
#SBATCH --mail-type=FAIL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=32G
#SBATCH --time=00:15:00
#SBATCH --qos=shared
#SBATCH --constraint=cpu

export OMP_NUM_THREADS='4'
export MPICH_MAX_THREAD_SAFETY='multiple'

export OMP_NUM_THREADS=4
export MPICH_MAX_THREAD_SAFETY=multiple
my_inputs=$@
srun -n 1 python ~/Repo/MAESTROeX/Exec/science/urca/analysis/scripts/volume-plot-rad_vel.py $my_inputs
