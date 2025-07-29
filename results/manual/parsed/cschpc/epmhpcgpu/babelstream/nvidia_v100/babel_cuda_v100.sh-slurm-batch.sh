#!/bin/bash
#SBATCH --job-name=babel_cuda
#SBATCH --account=project
#SBATCH --output=babel_cuda_v100_out
#SBATCH --error=babel_cuda_v100_error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=8000
#SBATCH --time=00:02:00
#SBATCH --partition=gpumedium

for i in {1..10}; do
        echo $i
        srun -n 1 ./cuda-stream;
        sleep 5;
done
