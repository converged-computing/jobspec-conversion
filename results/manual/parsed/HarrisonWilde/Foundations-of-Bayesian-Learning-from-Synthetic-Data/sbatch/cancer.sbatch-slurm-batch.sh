#!/bin/bash
#SBATCH --output=slurm.%N.%j.out
#SBATCH --error=slurm.%N.%j.err
#SBATCH --mail-user=h.wilde@warwick.ac.uk
#SBATCH --mail-type=ALL
#SBATCH --nodes=11
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4571
#SBATCH --time=2-00:00:00

export JULIA_PROJECT='/home/dcs/csrxgb/julia_stuff/Project.toml'
export JULIA_CMDSTAN_HOME='/home/dcs/csrxgb/julia_stuff/cmdstan-2.23.0'

export JULIA_PROJECT=/home/dcs/csrxgb/julia_stuff/Project.toml
export JULIA_CMDSTAN_HOME=/home/dcs/csrxgb/julia_stuff/cmdstan-2.23.0
module purge
module load GCC/8.3.0 GCCcore/9.2.0 Julia/1.4.1-linux-x86_64
julia ../src/logistic_regression/run.jl \
    --path /home/dcs/csrxgb/julia_stuff \
    --dataset kag_cervical_cancer \
    --label Biopsy \
    --epsilon 6.0 \
    --iterations 100 \
    --folds 5 \
    --sampler AHMC \
    --distributed
