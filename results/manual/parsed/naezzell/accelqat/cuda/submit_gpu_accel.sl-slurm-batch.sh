#!/bin/bash
#SBATCH --account=anakano_429
#SBATCH --output=gpu_accel_status.out
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k40:1
#SBATCH --time=00:10:00

julia --project=test try_gpu_accel.jl > gpu_accel_print.out
