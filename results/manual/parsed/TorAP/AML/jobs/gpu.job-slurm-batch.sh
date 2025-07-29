#!/bin/bash
#SBATCH --job-name=simple
#SBATCH --output=logs/job.%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu
#SBATCH --time=3-00:00:00
#SBATCH --partition=brown

module load Python/3.7.4-GCCcore-8.3.0
module load CUDA/10.2.89-GCC-8.3.0
source venv/bin/activate
python src/cyclegan_with_monitoring.py
