#!/bin/bash
#SBATCH --job-name=NDQN
#SBATCH --account=share-ie-idi
#SBATCH --output=job_output.out
#SBATCH --mail-user=ludvig.killingberg@ntnu.no
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=32GB
#SBATCH --time=3-00:00:00
#SBATCH --partition=GPUQ
#SBATCH: --exclusive
#SBATCH --constraint=V100|A100

module load Python/3.8.6-GCCcore-10.2.0
julia --optimize=3 --project=. scripts/run_experiment.jl
