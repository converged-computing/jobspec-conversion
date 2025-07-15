#!/bin/bash
#FLUX: --job-name=fmriprep_func
#FLUX: -c=40
#FLUX: -t=82800
#FLUX: --priority=16

export THREADS_PER_COMMAND='2'
export BIDS_DIR='${BASEDIR}/data/local/bids'
export FMRIPREP_HOME='${BASEDIR}/templates'
export SING_CONTAINER='${BASEDIR}/containers/fmriprep-20.2.7.simg'
export OUTPUT_DIR='${BASEDIR}/data/local/ # use if version of fmriprep <=21.0'
export WORK_DIR='${BBUFFER}/SCanD/${project_id}/fmriprep'
export LOGS_DIR='${BASEDIR}/logs'
export SINGULARITYENV_FS_LICENSE='/home/fmriprep/.freesurfer.txt'

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
export FMRIPREP_HOME=${BASEDIR}/templates
export SING_CONTAINER=${BASEDIR}/containers/fmriprep-20.2.7.simg
export OUTPUT_DIR=${BASEDIR}/data/local/ # use if version of fmriprep <=21.0
project_id=$(cat ${BASEDIR}/project_id)
export WORK_DIR=${BBUFFER}/SCanD/${project_id}/fmriprep
export LOGS_DIR=${BASEDIR}/logs
mkdir -vp ${OUTPUT_DIR} ${WORK_DIR} # ${LOCAL_FREESURFER_DIR}
bigger_bit=`echo "($SLURM_ARRAY_TASK_ID + 1) * ${SUB_SIZE}" | bc`
N_SUBJECTS=$(( $( wc -l ${BIDS_DIR}/participants.tsv | cut -f1 -d' ' ) - 1 ))
array_job_length=$(echo "$N_SUBJECTS/${SUB_SIZE}" | bc)
Tail=$((N_SUBJECTS-(array_job_length*SUB_SIZE)))
if [ "$SLURM_ARRAY_TASK_ID" -eq "$array_job_length" ]; then
    SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv  | head -n ${N_SUBJECTS} | tail -n ${Tail}`
else
    SUBJECTS=`sed -n -E "s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv | head -n ${bigger_bit} | tail -n ${SUB_SIZE}`
fi
export SINGULARITYENV_FS_LICENSE=/home/fmriprep/.freesurfer.txt
singularity run --cleanenv \
    -B ${BASEDIR}/templates:/home/fmriprep --home /home/fmriprep \
    -B ${BIDS_DIR}:/bids \
    -B ${OUTPUT_DIR}:/derived \
    -B ${WORK_DIR}:/work \
    ${SING_CONTAINER} \
    /bids /derived participant \
    --participant_label ${SUBJECTS} \
    -w /work \
    --skip-bids-validation \
    --cifti-output 91k \
    --omp-nthreads 8 \
    --nthreads 40 \
    --mem-mb 15000 \
    --output-space anat MNI152NLin6Asym:res-2 \
    --notrack \
    --use-syn-sdc \
    --ignore fieldmaps
exitcode=$?
for subject in $SUBJECTS; do
    if [ $exitcode -eq 0 ]; then
        echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    0" \
            >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
    else
        echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    fmriprep_func failed" \
            >> ${LOGS_DIR}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
    fi
done
