#!/bin/bash
#SBATCH --job-name=RESP2
#SBATCH --account=NN8050K
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2G
#SBATCH --time=00:45:00
#SBATCH --partition=normal

set -o errexit # Make bash exit on any error
set -o nounset # Treat unset variables as errors
module --quiet purge
module load R/4.1.2-foss-2021b
cd ~/binclassfound
Rscript cnn_mcmcp_2.R $SLURM_ARRAY_TASK_ID > cnn_mcmcp_2_$SLURM_ARRAY_TASK_ID.Rout 2>&1
