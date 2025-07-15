#!/bin/bash
#FLUX: --job-name=butterscotch-dog-7940
#FLUX: -c=16
#FLUX: -t=172800
#FLUX: --priority=16

export SINGULARITYENV_FS_LICENSE='$HOME/.freesurfer.txt'
export SINGULARITYENV_TEMPLATEFLOW_HOME='/templateflow'

BIDS_DIR="$STUDY/data"
DERIVS_DIR="derivatives/fmriprep-20.2.2"
LOCAL_FREESURFER_DIR="$STUDY/data/derivatives/freesurfer-6.0.1"
TEMPLATEFLOW_HOST_HOME=$HOME/.cache/templateflow
FMRIPREP_HOST_CACHE=$HOME/.cache/fmriprep
mkdir -p ${TEMPLATEFLOW_HOST_HOME}
mkdir -p ${FMRIPREP_HOST_CACHE}
mkdir -p ${BIDS_DIR}/${DERIVS_DIR}
export SINGULARITYENV_FS_LICENSE=$HOME/.freesurfer.txt
export SINGULARITYENV_TEMPLATEFLOW_HOME="/templateflow"
SINGULARITY_CMD="singularity run --cleanenv -B $BIDS_DIR:/data -B ${TEMPLATEFLOW_HOST_HOME}:${SINGULARITYENV_TEMPLATEFLOW_HOME} -B $L_SCRATCH:/work -B ${LOCAL_FREESURFER_DIR}:/fsdir $STUDY/images/fmriprep_20.2.2.simg"
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
find ${LOCAL_FREESURFER_DIR}/sub-$subject/ -name "*IsRunning*" -type f -delete
cmd="${SINGULARITY_CMD} /data /data/${DERIVS_DIR} participant --participant-label $subject -w /work/ -vv --omp-nthreads 8 --nthreads 12 --mem_mb 30000 --output-spaces MNI152NLin2009cAsym:res-2 anat fsnative fsaverage5 --use-aroma --fs-subjects-dir /fsdir"
echo Running task ${SLURM_ARRAY_TASK_ID}
echo Commandline: $cmd
eval $cmd
exitcode=$?
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
