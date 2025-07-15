#!/bin/bash
#FLUX: --job-name=crunchy-hobbit-5525
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export SINGULARITYENV_FS_LICENSE='$HOME/freesurfer/license.txt'
export SINGULARITYENV_TEMPLATEFLOW_HOME='/templateflow'

BIDS_DIR="/scratch/users/wiltho/data/esfmri"
DERIVS_DIR="derivatives/fmriprep-1.5.1"
mkdir -p $HOME/.cache/templateflow
mkdir -p ${BIDS_DIR}/${DERIVS_DIR}
mkdir -p ${BIDS_DIR}/derivatives/freesurfer-6.0.1
if [ ! -d ${BIDS_DIR}/${DERIVS_DIR}/freesurfer ]; then
    ln -s ${BIDS_DIR}/derivatives/freesurfer-6.0.1 ${BIDS_DIR}/${DERIVS_DIR}/freesurfer
fi
export SINGULARITYENV_FS_LICENSE=$HOME/freesurfer/license.txt
export SINGULARITYENV_TEMPLATEFLOW_HOME="/templateflow"
SINGULARITY_CMD="singularity run --cleanenv -B $BIDS_DIR:/data -B $HOME/.cache/templateflow:/templateflow -B $L_SCRATCH:/work $GROUP_HOME/singularity_images/poldracklab_fmriprep_1.5.1rc1-2019-10-15-dbef0fdcff8c.simg"
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
cmd="${SINGULARITY_CMD} /data /data/${DERIVS_DIR} participant --participant-label $subject -w /work/ -vv --use-syn-sdc --omp-nthreads 8 --nthreads 12 --mem_mb 30000 --output-spaces MNI152NLin2009cAsym:res-2 anat fsnative fsaverage5 --skip_bids_validation"
echo Running task ${SLURM_ARRAY_TASK_ID}
echo Commandline: $cmd
eval $cmd
exitcode=$?
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
