#!/bin/bash
#FLUX: --job-name=gradGen
#FLUX: -c=8
#FLUX: --urgency=16

SUBJECT_LIST=./SubjectsCompleteData.txt
smooth_kernel=$1
module load ConnectomeWorkbench/1.4.2-rh_linux64
module load Python/3.9.6-GCCcore-11.2.0
source /well/margulies/users/mnk884/python/corrmats-skylake/bin/activate
echo Executing task ${SLURM_ARRAY_TASK_ID} of job ${SLURM_ARRAY_JOB_ID} on `hostname` as user ${USER} 
echo "smoothing kernel is" ${smooth_kernel}
echo the job id is $SLURM_ARRAY_JOB_ID
FILENAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $SUBJECT_LIST)
echo echo $SLURM_ARRAY_JOB_ID
echo "Processing subject $FILENAME"
python -u GradDistCorrFullHCP.py --subj $FILENAME  --odir /well/margulies/projects/data/hcpGrads --kernel ${smooth_kernel}
