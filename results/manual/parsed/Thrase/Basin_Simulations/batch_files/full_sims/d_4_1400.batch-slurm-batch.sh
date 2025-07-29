#!/bin/bash
#SBATCH --job-name=14
#SBATCH --account=erickson
#SBATCH --output=../batch_output/d_4_1400.out
#SBATCH --error=../batch_output/d_4_1400.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:1
#SBATCH --mem=32G
#SBATCH --time=30-00:00:00
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --nodelist=n243

julia -t8 ../../Basin.jl ../../input_files/dynamic/large_simulations/d_4_1400.dat
