#!/bin/bash

#SBATCH --account=NN8050K
#SBATCH --job-name=RESP2
#SBATCH --partition=normal
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=2G
#SBATCH --time=00:45:00

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors

## module restore
module --quiet purge
module load R/4.1.2-foss-2021b
## module load R/4.1.0-foss-2021a
## module load intel/2020b

cd ~/binclassfound

Rscript cnn_mcmcp_2.R $SLURM_ARRAY_TASK_ID > cnn_mcmcp_2_$SLURM_ARRAY_TASK_ID.Rout 2>&1
