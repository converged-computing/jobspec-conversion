#!/bin/bash
#FLUX: --job-name=confused-punk-4289
#FLUX: -c=24
#FLUX: --queue=long
#FLUX: -t=172800
#FLUX: --urgency=16

export HOMES='/scratch/glerma'
export SINGULARITYENV_FS_LICENSE='$BIDS_DIR/.freesurfer.txt'
export SINGULARITYENV_TEMPLATEFLOW_HOME='/templateflow'

BIDS_DIR="$STUDY"
DERIVS_DIR="derivatives/fmriprep_21.0.2"
export HOMES=/scratch/glerma
LOCAL_FREESURFER_DIR="$STUDY/data/derivatives/freesurfer-7.2.0"
TEMPLATEFLOW_HOST_HOME=$HOMES/.cache/templateflow
FMRIPREP_HOST_CACHE=$HOMES/.cache/fmriprep
FMRIPREP_WORK_DIR=$HOMES/.work/fmriprep
mkdir -p ${TEMPLATEFLOW_HOST_HOME}
mkdir -p ${FMRIPREP_HOST_CACHE}
mkdir -p ${FMRIPREP_WORK_DIR}
mkdir -p ${BIDS_DIR}/${DERIVS_DIR}
export SINGULARITYENV_FS_LICENSE=$BIDS_DIR/.freesurfer.txt
export SINGULARITYENV_TEMPLATEFLOW_HOME="/templateflow"
SINGULARITY_CMD="unset PYTHONPATH && singularity run --cleanenv --no-home \
                 -B $BIDS_DIR:/data \
                 -B ${TEMPLATEFLOW_HOST_HOME}:${SINGULARITYENV_TEMPLATEFLOW_HOME} \
                 -B ${FMRIPREP_HOST_CACHE}:/work \
                 /scratch/glerma/containers/fmriprep_21.0.2.sif"
                 # If you already have FS run, add this line to find it
                 # -B ${LOCAL_FREESURFER_DIR}:/fsdir \
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
cmd="module load Singularity/3.5.3-GCC-8.3.0 &&  \
     ${SINGULARITY_CMD} \
     /data \
     /data/${DERIVS_DIR} \
     participant --participant-label $subject \
     -w /work/ -vv --omp-nthreads 8 --nthreads 12 --mem 16G \
     --output-spaces fsnative fsaverage \
     --use-aroma"
echo Running task ${SLURM_ARRAY_TASK_ID}, for subject ${subject}
echo Commandline: $cmd
eval $cmd
exitcode=$?
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID} $exitcode" >> ${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
