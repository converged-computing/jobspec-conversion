#!/bin/bash
#SBATCH --output=results/%x/%j-slurm.out
#SBATCH --error=results/%x/%j-slurm.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=9G
#SBATCH --time=02:00:00
#SBATCH --constraint=intel

set -e
module purge
ENV_PREFIX=$PROJECT_DIR/env
conda activate $ENV_PREFIX
python $1
