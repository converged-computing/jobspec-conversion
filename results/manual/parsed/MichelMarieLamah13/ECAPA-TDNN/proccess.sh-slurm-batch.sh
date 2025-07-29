#!/bin/bash
#SBATCH --job-name=bp
#SBATCH --output=bp_output.log
#SBATCH --error=bp_error.log
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=16GB
#SBATCH --time=7-00:00:00

source /etc/profile.d/conda.sh
conda activate ecapa_tdnn
conda deactivate
