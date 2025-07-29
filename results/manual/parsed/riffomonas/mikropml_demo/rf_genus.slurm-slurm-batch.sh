#!/bin/bash
#SBATCH --account=pschloss1
#SBATCH --output=%x.o%A_%a
#SBATCH --mail-user=you@umich.edu
#SBATCH --mail-type=BEGIN,END
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=4g
#SBATCH --time=1-00:00:00
#SBATCH --partition=standard
#SBATCH --constraint=ntasks-per-node=1
#SBATCH --array=1-100

SEED=$((SLURM_ARRAY_TASK_ID))
echo $SEED
make processed_data/rf_genus_$SEED.Rds
