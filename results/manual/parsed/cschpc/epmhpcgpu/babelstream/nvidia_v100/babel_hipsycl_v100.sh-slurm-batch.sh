#!/bin/bash
#SBATCH --job-name=babel_hipsycl
#SBATCH --account=project
#SBATCH --output=babel_hipsycl_v100_out
#SBATCH --error=babel_hipsycl_v100_error
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=8000
#SBATCH --time=00:02:00

for i in {1..10}; do
        echo $i
        srun -n 1 ./sycl-stream --device 1;
        sleep 5;
done
