#!/bin/bash
#SBATCH --job-name=prfprepare
#SBATCH --output=/scratch/glerma/logs/%x-%A-%a.out
#SBATCH --error=/scratch/glerma/logs/%x-%A-%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem=24000
#SBATCH --time=01:00:00
#SBATCH --partition=regular

export SINGULARITYENV_FS_LICENSE='/flywheel/v0/BIDS/.freesurfer.txt'

export SINGULARITYENV_FS_LICENSE=/flywheel/v0/BIDS/.freesurfer.txt
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${basedir}/BIDS/participants.tsv )
echo 
SINGULARITY_CMD="module load Singularity/3.5.3-GCC-8.3.0 && \
                 unset PYTHONPATH && \
                 singularity run --cleanenv --home /scratch/glerma \
                     -B ${basedir}/BIDS/derivatives/fmriprep_21.0.2:/flywheel/v0/input \
                     -B ${basedir}/BIDS/derivatives:/flywheel/v0/output  \
                     -B ${basedir}/BIDS:/flywheel/v0/BIDS  \
                     -B ${basedir}/config${subject}.json:/flywheel/v0/config.json
                      /scratch/glerma/containers/prfprepare_1.0.2.sif"
echo Running task ${SLURM_ARRAY_TASK_ID}, for subject ${subject}
echo Commandline: $SINGULARITY_CMD
eval $SINGULARITY_CMD
exitcode=$?
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID} $exitcode" >> ${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
