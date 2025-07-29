#!/bin/bash
#SBATCH --job-name=motif_array
#SBATCH --output=../downstream/logfiles/motif_all-default-%x-%A-%a.out
#SBATCH --error=../downstream/logfiles/motif_all-default-%x-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --time=12:00:00
#SBATCH --partition=shared,parallel,skylake
#SBATCH --array=1-50

ml R/3.6.1
ml atlas
ml intel/18.0
Rscript --vanilla motif_break_array.R "$SLURM_ARRAY_TASK_ID" variant_in_all.rds 50 motif_all_JASPAR default 
