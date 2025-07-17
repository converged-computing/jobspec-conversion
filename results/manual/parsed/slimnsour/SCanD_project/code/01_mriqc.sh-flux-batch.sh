#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -c=80
#FLUX: -t=43200
#FLUX: --urgency=16

export THREADS_PER_COMMAND='2'
export BIDS_DIR='${BASEDIR}/data/local/bids'
export FMRIPREP_HOME='${BASEDIR}/templates'
export SING_CONTAINER='${BASEDIR}/containers/mriqc-22.0.6.simg'
export OUTPUT_DIR='${BASEDIR}/data/local/mriqc # use if version of fmriprep <=20.1'
export WORK_DIR='${BBUFFER}/SCanD/mriqc'
export LOGS_DIR='${BASEDIR}/logs'
export SINGULARITYENV_FS_LICENSE='/home/mriqc/.freesurfer.txt'

SUB_SIZE=10 ## number of subjects to run
export THREADS_PER_COMMAND=2
BASEDIR=${SLURM_SUBMIT_DIR}
function cleanup_ramdisk {
    echo -n "Cleaning up ramdisk directory /$SLURM_TMPDIR/ on "
    date
    rm -rf /$SLURM_TMPDIR
    echo -n "done at "
    date
}
trap "cleanup_ramdisk" TERM
export BIDS_DIR=${BASEDIR}/data/local/bids
export FMRIPREP_HOME=${BASEDIR}/templates
export SING_CONTAINER=${BASEDIR}/containers/mriqc-22.0.6.simg
export OUTPUT_DIR=${BASEDIR}/data/local/mriqc # use if version of fmriprep <=20.1
export WORK_DIR=${BBUFFER}/SCanD/mriqc
export LOGS_DIR=${BASEDIR}/logs
mkdir -vp ${OUTPUT_DIR} ${WORK_DIR} # ${LOCAL_FREESURFER_DIR}
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
export SINGULARITYENV_FS_LICENSE=/home/mriqc/.freesurfer.txt
singularity run --cleanenv \
    -B ${BASEDIR}/templates:/home/mriqc --home /home/mriqc \
    -B ${BIDS_DIR}:/bids \
    -B ${OUTPUT_DIR}:/derived \
    -B ${WORK_DIR}:/work \
    ${SING_CONTAINER} \
    /bids /derived participant \
    --participant-label ${SUBJECTS} \
    -w /work \
    --nprocs 12 \
    --ants-nthreads 8 \
    --verbose-reports \
    --ica \
    --mem_gb 12 \
    --no-sub
exitcode=$?
 #   -B ${BIDS_DIR}:/bids \
 #   -B ${OUTPUT_DIR}:/out \
 #   -B ${LOCAL_FREESURFER_DIR}:/fsdir \
for subject in $SUBJECTS; do
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
done
