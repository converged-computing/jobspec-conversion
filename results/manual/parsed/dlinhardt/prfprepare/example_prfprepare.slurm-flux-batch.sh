#!/bin/bash
#FLUX: --job-name=prfprepare
#FLUX: -c=10
#FLUX: --queue=regular
#FLUX: -t=3600
#FLUX: --urgency=16

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
