#!/bin/bash
#FLUX: --job-name=fmriprep_anat
#FLUX: -c=40
#FLUX: -t=86400
#FLUX: --priority=16

export THREADS_PER_COMMAND='2'
export BIDS_DIR='${SCRATCH}/${STUDY}/data/input/bids'
export FMRIPREP_HOME='$SCRATCH/fmriprep_home'
export SING_CONTAINER='${SCRATCH}/${STUDY}/envs/fmriprep-20.1.1.simg'
export OUTPUT_DIR='${SCRATCH}/${STUDY}/data/derived/'
export WORK_DIR='${BBUFFER}/${STUDY}/fmriprep'
export LOGS_DIR='${SCRATCH}/${STUDY}/logs'
export SINGULARITYENV_TEMPLATEFLOW_HOME='/home/fmriprep/.cache/templateflow'
export SINGULARITYENV_FS_LICENSE='/home/fmriprep/.freesurfer.txt'

SUB_SIZE=5 ## number of subjects to run
CORES=40
export THREADS_PER_COMMAND=2
STUDY='ds000201_preproc'
function cleanup_ramdisk {
    echo -n "Cleaning up ramdisk directory /$SLURM_TMPDIR/ on "
    date
    rm -rf /$SLURM_TMPDIR
    echo -n "done at "
    date
}
trap "cleanup_ramdisk" TERM
export BIDS_DIR=${SCRATCH}/${STUDY}/data/input/bids
export FMRIPREP_HOME=$SCRATCH/fmriprep_home
export SING_CONTAINER=${SCRATCH}/${STUDY}/envs/fmriprep-20.1.1.simg
export OUTPUT_DIR=${SCRATCH}/${STUDY}/data/derived/
export WORK_DIR=${BBUFFER}/${STUDY}/fmriprep
export LOGS_DIR=${SCRATCH}/${STUDY}/logs
mkdir -vp ${OUTPUT_DIR} ${WORK_DIR} ${LOGS_DIR} # ${LOCAL_FREESURFER_DIR}
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
export SINGULARITYENV_TEMPLATEFLOW_HOME=/home/fmriprep/.cache/templateflow
export SINGULARITYENV_FS_LICENSE=/home/fmriprep/.freesurfer.txt
cd ${SCRATCH}/${STUDY}
singularity run --cleanenv \
    -B ${SCRATCH}/fmriprep_home:/home/fmriprep --home /home/fmriprep \
    -B ${WORK_DIR}:/work \
    ${SING_CONTAINER} \
    data/input/bids data/derived participant \
    --participant_label ${SUBJECTS} \
    -w /work \
    --skip-bids-validation \
    --omp-nthreads 8 \
    --output-space T1w MNI152NLin2009cAsym \
    --use-aroma \
    --notrack \
    --cifti-output 91k \
    --anat-only 
exitcode=$?
 #   -B ${BIDS_DIR}:/bids \
 #   -B ${OUTPUT_DIR}:/out \
 #   -B ${LOCAL_FREESURFER_DIR}:/fsdir \
for subject in $SUBJECTS; do
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
done
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
