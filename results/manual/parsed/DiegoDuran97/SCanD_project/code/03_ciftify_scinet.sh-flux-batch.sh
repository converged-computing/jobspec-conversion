#!/bin/bash
#FLUX: --job-name=ciftify
#FLUX: -c=8
#FLUX: -t=14400
#FLUX: --urgency=16

export THREADS_PER_COMMAND='2'
export BIDS_DIR='${BASEDIR}/data/local/bids'
export SING_CONTAINER='${BASEDIR}/containers/fmriprep_ciftity-v1.3.2-2.3.3.simg'
export OUTPUT_DIR='${BASEDIR}/data/local/'
export LOGS_DIR='${BASEDIR}/logs'
export ORIG_FS_LICENSE='${BASEDIR}/templates/.freesurfer.txt'
export SINGULARITYENV_FS_LICENSE='/.freesurfer.txt'

SUB_SIZE=1 ## number of subjects to run
CORES=8
export THREADS_PER_COMMAND=2
module load gnu-parallel/20191122
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
export SING_CONTAINER=${BASEDIR}/containers/fmriprep_ciftity-v1.3.2-2.3.3.simg
export OUTPUT_DIR=${BASEDIR}/data/local/
export LOGS_DIR=${BASEDIR}/logs
mkdir -vp ${OUTPUT_DIR} ${WORK_DIR} # ${LOCAL_FREESURFER_DIR}
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
export ORIG_FS_LICENSE=${BASEDIR}/templates/.freesurfer.txt
export SINGULARITYENV_FS_LICENSE=/.freesurfer.txt
parallel -j 8 "singularity run --cleanenv \
    -H $(mktemp -d -t wb-XXXXXXXXXX) \
    -B ${BIDS_DIR}:/bids \
    -B ${OUTPUT_DIR}:/derived \
    -B ${ORIG_FS_LICENSE}:${SINGULARITYENV_FS_LICENSE} \
    ${SING_CONTAINER} \
      /bids /derived participant \
      --participant_label={} \
      --read-from-derivatives /derived \
      --fs-license ${SINGULARITYENV_FS_LICENSE} \
      --n_cpus 10" \
      ::: ${SUBJECTS}
exitcode=$?
for subject in $SUBJECTS; do
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
done
