#!/bin/bash
#SBATCH --job-name=DCCR-10
#SBATCH --output=/home/sap625/logs/out/%j.out
#SBATCH --error=/home/sap625/logs/err/%j.err
#SBATCH --mail-user=sap625@mst.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
#SBATCH --time=1-00:00:00

N_TASKS=31
PROJECT_DIR=$HOME/dev/DCCR
VENV_DIR=$HOME/envs/l2m
JULIA_BIN=$HOME/julia
date
ls -la
source $VENV_DIR/bin/activate
$JULIA_BIN $PROJECT_DIR/src/experiments/10_l2m_dist/3_dist_driver.jl $N_TASKS
echo --- END OF CUDA CHECK ---
echo All is quiet on the western front
