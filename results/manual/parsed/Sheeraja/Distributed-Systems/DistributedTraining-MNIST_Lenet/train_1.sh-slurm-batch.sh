#!/bin/bash
#SBATCH --job-name=DagTrain1
#SBATCH --account=evidential
#SBATCH --output=%x_%j.out
#SBATCH --error=%x_%j.err
#SBATCH --mail-user=sheeraja206@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=2
#SBATCH --gres=gpu:a100:2
#SBATCH --mem-per-cpu=0
#SBATCH --time=03:00:00
#SBATCH --partition=debug

export PATH='$PATH:~/julia-1.8.5/bin'

export PATH="$PATH:~/julia-1.8.5/bin"
julia --project="/home/sr8685/distributed_systems/DaggerTraining" --threads=auto /home/sr8685/distributed_systems/DaggerTraining/train_1.jl
