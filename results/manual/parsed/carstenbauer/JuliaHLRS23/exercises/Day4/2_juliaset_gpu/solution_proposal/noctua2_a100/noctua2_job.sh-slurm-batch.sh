#!/bin/bash
#SBATCH --job-name=juliaset_gpu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --gres=gpu:a100:1
#SBATCH --time=00:15:00
#SBATCH --qos=devel

ml r
ml lang JuliaHPC
julia --project ../juliaset_gpu.jl
