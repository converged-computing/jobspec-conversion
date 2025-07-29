#!/bin/bash
#SBATCH --job-name=GradDist
#SBATCH --output=./logs/gradDistJob-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --constraint=skl-compat
#SBATCH --array=1-972:1

SUBJECT_LIST=./results/CleanSujects4Dist.txt
module load ConnectomeWorkbench/1.4.2-rh_linux64
module load Python/3.9.6-GCCcore-11.2.0
source /well/margulies/users/mnk884/python/measureDist-skylake/bin/activate
echo Executing task ${SLURM_ARRAY_TASK_ID} of job ${SLURM_ARRAY_JOB_ID} on `hostname` as user ${USER} 
echo "smoothing kernel is" ${smooth_kernel}
echo the job id is $SLURM_ARRAY_JOB_ID
FILENAME=$(sed -n "${SLURM_ARRAY_TASK_ID}p" $SUBJECT_LIST)
echo echo $SLURM_ARRAY_JOB_ID
echo "Processing subject $FILENAME"
python -u CalcGrad2CortDist.py $FILENAME 
