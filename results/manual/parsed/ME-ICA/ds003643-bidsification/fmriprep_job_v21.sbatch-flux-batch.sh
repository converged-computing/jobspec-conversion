#!/bin/bash
#FLUX: --job-name=lpp
#FLUX: -c=8
#FLUX: --queue=IB_40C_512G
#FLUX: -t=216000
#FLUX: --urgency=16

export SINGULARITYENV_TEMPLATEFLOW_HOME='$HOME/.cache/templateflow'

pwd; hostname; date
set -e
module load singularity-3.5.3
IMG_DIR="/home/data/cis/singularity-images"
DATA_DIR="/home/data/nbc"
BIDS_DIR="${DATA_DIR}/external-datasets/ds003643"
CODE_DIR="${DATA_DIR}/external-datasets/ds003643/code"
DERIVS_DIR="${BIDS_DIR}/derivatives/fmriprep-v21.0.0"
mkdir -p ${DERIVS_DIR}
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
WORK_DIR="${BIDS_DIR}/work/fmriprep-${subject}"
mkdir -p ${WORK_DIR}
TEMPLATEFLOW_HOST_HOME="${HOME}/.cache/templateflow"
FMRIPREP_HOST_CACHE="$HOME/.cache/fmriprep"
mkdir -p ${FMRIPREP_HOST_CACHE}
FS_LICENSE="${HOME}/freesurfer_license.txt"
export SINGULARITYENV_TEMPLATEFLOW_HOME="$HOME/.cache/templateflow"
SINGULARITY_CMD="singularity run --cleanenv \
      -B ${BIDS_DIR}:/data \
      -B ${DERIVS_DIR}:/out \
      -B ${TEMPLATEFLOW_HOST_HOME}:${SINGULARITYENV_TEMPLATEFLOW_HOME} \
      -B ${WORK_DIR}:/work \
      ${IMG_DIR}/poldracklab-fmriprep_21.0.0.sif"
cmd="${SINGULARITY_CMD} /data \
      /out \
      participant \
      --participant-label $subject \
      -w /work/ \
      -vv \
      --omp-nthreads 8 \
      --nprocs 8 \
      --mem_mb 32000 \
      --output-spaces MNI152NLin6Asym:res-native anat:res-native func:res-native \
      --me-output-echos \
      --notrack \
      --stop-on-first-crash \
      --skip_bids_validation \
      --fs-license-file $FS_LICENSE"
echo Running task ${SLURM_ARRAY_TASK_ID}
echo Commandline: $cmd
eval $cmd
exitcode=$?
rm -rf ${WORK_DIR}
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${CODE_DIR}/jobs/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
exit $exitcode
date
