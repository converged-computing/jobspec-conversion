#!/bin/bash
#SBATCH --job-name=hm-2020-07-21-Hirundo_rustica
#SBATCH --output=/labs/Tingley/phenomismatch/Bird_Phenology/Data/Processed/arrival_IAR_hm_2020-07-21/Hirundo_rustica-iar-hm.out
#SBATCH --error=/labs/Tingley/phenomismatch/Bird_Phenology/Data/Processed/arrival_IAR_hm_2020-07-21/Hirundo_rustica-iar-hm.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=10G
#SBATCH --partition=general
#SBATCH --qos=general

echo `hostname`
module load gcc/6.4.0
module load singularity/3.0.2
singularity exec -B /labs/Tingley -B /UCHC /isg/shared/apps/R/3.5.2/R.sif Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/4-arr-IAR-hm/4-arr-IAR-hm.R Hirundo_rustica 5000
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch
