#!/bin/bash
#SBATCH --job-name=Qsite
#SBATCH --output=mpi_%j.out
#SBATCH --error=mpi_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=02:00:00
#SBATCH --qos=debug
#SBATCH --constraint=schrodinger

export PATH='$PATH:/gpfs/projects/bsc72/Programs/schrodinger2024-1'
export SCHRODINGER='/gpfs/projects/bsc72/Programs/schrodinger2024-1'

export PATH=$PATH:/gpfs/projects/bsc72/Programs/schrodinger2024-1
export SCHRODINGER=/gpfs/projects/bsc72/Programs/schrodinger2024-1
$SCHRODINGER/qsite -PARALLEL 4 -WAIT e0_t74_st57_en-18.3_dis5.29_1.in
