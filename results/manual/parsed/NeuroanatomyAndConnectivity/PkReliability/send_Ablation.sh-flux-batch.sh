#!/bin/bash
#FLUX: --job-name=AblationAnalysis
#FLUX: -c=3
#FLUX: --priority=16

SUBJECT_LIST=./text_files/subjectsWithParietalPeak.txt
module load Python/3.9.6-GCCcore-11.2.0
source /well/margulies/users/mnk884/python/measureDist-skylake/bin/activate
echo the job id is $SLURM_ARRAY_JOB_ID
SUBJECT=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $SUBJECT_LIST)
echo "performng ablation analysis for $SUBJECT"
python3 -u lin_regAblation.py $SUBJECT 
