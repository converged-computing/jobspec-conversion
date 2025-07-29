#!/bin/bash
#SBATCH --job-name=port_batched
#SBATCH --mail-user=shalin_patel@brown.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=20G
#SBATCH --time=1-06:00:00
#SBATCH --constraint=v100

source ~/ml/bin/activate
julia port_batched.jl
