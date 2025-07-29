#!/bin/bash
#SBATCH --job-name=create_env
#SBATCH --account=project_465000872
#SBATCH --output=logs/create_env_output_%j
#SBATCH --error=logs/create_env_error_%j
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=20:00:00

module load LUMI/22.08
module load cotainr
cotainr build final_container.sif  --base-image=docker://rocm/dev-ubuntu-22.04:5.3.2-complete --conda-env=final-env.yml
