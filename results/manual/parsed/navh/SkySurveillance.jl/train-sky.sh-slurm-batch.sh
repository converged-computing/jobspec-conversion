#!/bin/bash
#SBATCH --account=def-rsadve
#SBATCH --output=t-stdenv23-julia19-%N-%j.out
#SBATCH --mail-user=<a.hebb@mail.utoronto.ca>
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:1
#SBATCH --mem=24G
#SBATCH --time=02:34:56

module purge
module load StdEnv/2023
module load cuda # Remove this line if not using a GPU
module load julia/1.9
module lead nvptx-tools
julia --project src/SkySurveillance.jl params-test.toml
