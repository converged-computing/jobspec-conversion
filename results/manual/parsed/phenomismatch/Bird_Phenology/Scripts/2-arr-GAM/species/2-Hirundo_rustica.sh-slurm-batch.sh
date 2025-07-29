#!/bin/bash
#SBATCH --job-name=arr-GAM-Hirundo_rustica
#SBATCH --output=/labs/Tingley/phenomismatch/Bird_Phenology/Data/Processed/arrival_GAM_2020-07-10/arr-GAM-Hirundo_rustica.out
#SBATCH --error=/labs/Tingley/phenomismatch/Bird_Phenology/Data/Processed/arrival_GAM_2020-07-10/arr-GAM-Hirundo_rustica.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --partition=general
#SBATCH --qos=general

echo `hostname`
module load gcc/6.4.0
module load singularity/3.0.2
singularity exec -B /labs/Tingley -B /UCHC /isg/shared/apps/R/3.5.2/R.sif Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM.R Hirundo_rustica 2002 2017
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch
