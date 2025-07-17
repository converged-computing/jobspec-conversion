#!/bin/bash
#FLUX: --job-name=arr-GAM-Hirundo_rustica
#FLUX: -c=4
#FLUX: --queue=general
#FLUX: --urgency=16

echo `hostname`
module load gcc/6.4.0
module load singularity/3.0.2
singularity exec -B /labs/Tingley -B /UCHC /isg/shared/apps/R/3.5.2/R.sif Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/2-arr-GAM/2-arr-GAM.R Hirundo_rustica 2002 2017
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch
