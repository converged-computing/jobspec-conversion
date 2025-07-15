#!/bin/bash
#FLUX: --job-name=amico_noddi
#FLUX: -c=40
#FLUX: -t=21600
#FLUX: --priority=16

export THREADS_PER_COMMAND='2'
export BIDS_DIR='${BASEDIR}/data/local/bids'
export QSIPREP_DIR='${BASEDIR}/data/local/qsiprep'
export SING_CONTAINER='${BASEDIR}/containers/pennbbl_qsiprep_0.14.3-2021-09-16-e97e6c169493.simg'
export OUTPUT_DIR='${BASEDIR}/data/local/amico_noddi '
export TMP_DIR='${BASEDIR}/data/local/amico_noddi/tmp'
export WORK_DIR='${BBUFFER}/SCanD/amico'
export LOGS_DIR='${BASEDIR}/logs'
export SINGULARITYENV_FS_LICENSE='${BASEDIR}/templates/.freesurfer.txt'

SUB_SIZE=1 ## number of subjects to run is 1 because there are multiple tasks/run that will run in parallel 
CORES=40
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
export QSIPREP_DIR=${BASEDIR}/data/local/qsiprep
export SING_CONTAINER=${BASEDIR}/containers/pennbbl_qsiprep_0.14.3-2021-09-16-e97e6c169493.simg
export OUTPUT_DIR=${BASEDIR}/data/local/amico_noddi 
export TMP_DIR=${BASEDIR}/data/local/amico_noddi/tmp
export WORK_DIR=${BBUFFER}/SCanD/amico
export LOGS_DIR=${BASEDIR}/logs
mkdir -vp ${OUTPUT_DIR} ${WORK_DIR} ${TMP_DIR}
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
N_SUBJECTS=$(( $( wc -l ${BIDS_DIR}/participants.tsv | cut -f1 -d' ' ) - 1 ))
array_job_length=$(echo "$N_SUBJECTS/${SUB_SIZE}" | bc)
Tail=$((N_SUBJECTS-(array_job_length*SUB_SIZE)))
if [ "$SLURM_ARRAY_TASK_ID" -eq "$array_job_length" ]; then
    SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv  | head -n ${N_SUBJECTS} | tail -n ${Tail}`
else
    SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
fi
export SINGULARITYENV_FS_LICENSE=${BASEDIR}/templates/.freesurfer.txt
singularity run --cleanenv \
  -H ${TMP_DIR} \
  -B ${BIDS_DIR}:/bids \
  -B ${QSIPREP_DIR}:/qsiprep \
  -B ${OUTPUT_DIR}:/out \
  -B ${WORK_DIR}:/work \
  -B ${SINGULARITYENV_FS_LICENSE}:/li \
  ${SING_CONTAINER} \
  /bids /out participant \
  --skip-bids-validation \
  --participant_label ${SUBJECTS} \
  --recon-only \
  --recon-spec amico_noddi \
  --recon-input /qsiprep \
  --n_cpus 4 --omp-nthreads 2 \
  --output-resolution 1.7 \
  --fs-license-file /li \
  -w /work \
  --notrack
  exitcode=$?
for subject in $SUBJECTS; do
    if [ $exitcode -eq 0 ]; then
        echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    0" \
            >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
    else
        echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    amico failed" \
            >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
    fi
done
