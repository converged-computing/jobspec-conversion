#!/bin/bash
#SBATCH --job-name=virian
#SBATCH --account=students
#SBATCH --output=logs/train.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=30G
#SBATCH --time=00:59:00

module --ignore-cache load singularity/3.4.1
module --ignore-cache load CUDA/11.1.1-GCC-10.2.0
srun singularity exec --nv container.sif python3.11 main.py
