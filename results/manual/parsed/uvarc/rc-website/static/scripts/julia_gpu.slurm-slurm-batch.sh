#!/bin/bash
#SBATCH --account=hpc_build
#SBATCH --output=run_gpu_%A.out
#SBATCH --error=run_gpu_%A.err
#SBATCH --mail-user=teh1m@virginia.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:1
#SBATCH --time=01:00:00
#SBATCH --constraint=ntasks-per-node=1

echo 'slurm allocates gpus ' $CUDA_VISIBLE_DEVICES
module purge
module load julia/1.5.0 cuda/10.2.89
julia gpuTest1.jl
