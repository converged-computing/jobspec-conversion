#!/bin/bash
#FLUX: --job-name=Watershed
#FLUX: -c=3
#FLUX: --urgency=16

SUBJECT_LIST=./subjectsWithParietalPeak.txt
module load ConnectomeWorkbench/1.4.2-rh_linux64
module load Python/3.9.6-GCCcore-11.2.0
source /well/margulies/users/mnk884/python/postHoc-permutations-skl/bin/activate
echo Executing task ${SLURM_ARRAY_TASK_ID} of job ${SLURM_ARRAY_JOB_ID} on `hostname` as user ${USER} 
echo "smoothing kernel is" ${smooth_kernel}
echo the job id is $SLURM_ARRAY_JOB_ID
FILENAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $SUBJECT_LIST)
echo echo $SLURM_ARRAY_JOB_ID
echo "Processing subject $FILENAME"
SUBJECT=$(sed -n "${SGE_TASK_ID}p" $SUBJECT_LIST)
echo python3 -u IndividualWatershed.py $SUBJECT
python3 -u IndividualWatershed.py $FILENAME
