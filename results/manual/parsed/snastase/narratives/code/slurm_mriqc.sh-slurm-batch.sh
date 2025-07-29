#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -c=8
#FLUX: --queue=all
#FLUX: -t=10800
#FLUX: --urgency=16

echo "Purging modules"
module purge
echo "Slurm job ID: " $SLURM_JOB_ID
echo "Slurm array task ID: " $SLURM_ARRAY_TASK_ID
date
printf -v subj "%03d" $SLURM_ARRAY_TASK_ID
echo "Running MRIQC on sub-$subj"
./run_mriqc.sh $subj
echo "Finished running MRIQC on sub-$subj"
date
