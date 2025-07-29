#!/bin/bash
#SBATCH --job-name=h2o_arrayJob
#SBATCH --output=h2o_arrayJob_%A_%a.out
#SBATCH --error=h2o_arrayJob_%A_%a.err
#SBATCH --mail-user=richherr@unt.edu
#SBATCH --mail-type=end
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=02:00:00

source ~/conda.init
conda activate h2oai
srun python h2o_randomForest.py
