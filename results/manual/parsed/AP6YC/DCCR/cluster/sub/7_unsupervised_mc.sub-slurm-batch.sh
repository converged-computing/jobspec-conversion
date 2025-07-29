#!/bin/bash
#SBATCH --job-name=DCCR-7
#SBATCH --output=/home/sap625/logs/out/%j.out
#SBATCH --error=/home/sap625/logs/err/%j.err
#SBATCH --mail-user=sap625@mst.edu
#SBATCH --mail-type=begin,end,fail,requeue
#SBATCH --nodes=1
#SBATCH --ntasks=32
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2000
#SBATCH --time=1-00:00:00

N_TASKS=31
PROJECT_DIR=$HOME/dev/DCCR
VENV_DIR=$HOME/.venv/DCCR
JULIA_BIN=$HOME/julia
date
ls -la
$JULIA_BIN $PROJECT_DIR/src/experiments/7_unsupervised_mc/7_unsupervised_mc.jl $N_TASKS
echo --- END OF CUDA CHECK ---
echo All is quiet on the western front
