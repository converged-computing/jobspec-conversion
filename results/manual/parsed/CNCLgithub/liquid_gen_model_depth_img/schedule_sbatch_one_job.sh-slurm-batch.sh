#!/bin/bash
#SBATCH --job-name=liquid_gen
#SBATCH --output=job_%A_%a.out
#SBATCH --mail-user=yuting.zhang@yale.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=2-00:00:00

pwd; hostname; date
./run.sh julia src/exp_basic.jl 2/boxwithahole_16
date
if [[ "$@" =~ "on" ]];then
    rm -rf ../SPlisHSPlasH/bin/output/simulation_422
fi
