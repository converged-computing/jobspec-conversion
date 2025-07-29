#!/bin/bash
#SBATCH --job-name=job-serial
#SBATCH --account=Project-ID
#SBATCH --output=job.%J.out
#SBATCH --error=job.%J.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:k80:1
#SBATCH --time=00:20:00

ml purge  > /dev/null 2>&1
ml Julia/1.8.5-linux-x86_64
ml CUDA/11.4.1
julia <fix-activate-environment> <fix-name-script>.jl 
