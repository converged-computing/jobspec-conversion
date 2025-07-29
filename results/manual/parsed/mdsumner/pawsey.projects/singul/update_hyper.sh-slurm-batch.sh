#!/bin/bash
#SBATCH --account=pawsey0973
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=20000
#SBATCH --time=01:00:00
#SBATCH --partition=copy

module load singularity/3.11.4-slurm
mv  $MYSOFTWARE/sif_lib/hypertidy_main.sif  $MYSOFTWARE/sif_lib/hypertidy_main_`date -I`.sif
singularity pull --dir $MYSOFTWARE/sif_lib docker://mdsumner/hypertidy:main
