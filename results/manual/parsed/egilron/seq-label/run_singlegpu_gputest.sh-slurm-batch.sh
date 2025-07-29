#!/bin/bash
#SBATCH --job-name=singlegpu_gputest_example
#SBATCH --account=project_465000144
#SBATCH --output=output_%x_%j.txt
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gpus-per-task=1
#SBATCH --time=00:05:00

srun singularity exec lumi_pytorch_rocm_demo.sif python3 pytorch_singlegpu_gputest.py
