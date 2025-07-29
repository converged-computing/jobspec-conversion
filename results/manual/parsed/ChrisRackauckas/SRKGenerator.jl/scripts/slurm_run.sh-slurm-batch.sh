#!/bin/bash
#SBATCH --job-name=SRK
#SBATCH --account=uci131
#SBATCH --output=output/jOpt.%j.%N.out
#SBATCH --mail-user=crackauc@uci.edu
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --mem=16G
#SBATCH --time=12:00:00
#SBATCH --constraint=ntasks-per-node=1

module load cuda/7.0
module load cmake
/home/crackauc/julia-3c9d75391c/bin/julia /home/crackauc/.julia/v0.5/SRKGenerator/test/runtests.jl 2496 $1 $2
