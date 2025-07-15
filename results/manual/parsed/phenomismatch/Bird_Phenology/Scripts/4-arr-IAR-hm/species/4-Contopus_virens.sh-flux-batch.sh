#!/bin/bash
#FLUX: --job-name=hm-2020-07-21-Contopus_virens
#FLUX: --queue=general #partition - can also specify 'himem'
#FLUX: --priority=16

echo `hostname`
module load gcc/6.4.0
module load singularity/3.0.2
singularity exec -B /labs/Tingley -B /UCHC /isg/shared/apps/R/3.5.2/R.sif Rscript /labs/Tingley/phenomismatch/Bird_Phenology/Scripts/4-arr-IAR-hm/4-arr-IAR-hm.R Contopus_virens 5000
sstat --format="AveCPU,AvePages,AveRSS,MaxRSS,AveVMSize,MaxVMSize" $SLURM_JOBID.batch
