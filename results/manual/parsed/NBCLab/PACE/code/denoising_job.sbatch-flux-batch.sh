#!/bin/bash
#FLUX: --job-name=denoising
#FLUX: -c=4
#FLUX: --queue=bluemoon
#FLUX: -t=7200
#FLUX: --urgency=16

pwd; hostname; date
set -e
module load singularity/3.7.1
DATA="ATS"
HOST_DIR="/gpfs1/home/m/r/mriedel"
PROJECT="pace"
DSETS_DIR="${HOST_DIR}/${PROJECT}/dsets"
CODE_DIR="${HOST_DIR}/${PROJECT}/code"
BIDS_DIR="${DSETS_DIR}/dset-${DATA}"
IMG_DIR="${HOST_DIR}/${PROJECT}/software"
DERIVS_DIR="${BIDS_DIR}/derivatives"
mriqc_ver=0.16.1
fmriprep_ver=20.2.5
afni_ver=22.0.20
MRIQC_DIR="${DERIVS_DIR}/mriqc-${mriqc_ver}"
FMRIPREP_DIR="${DERIVS_DIR}/fmriprep-${fmriprep_ver}/fmriprep"
CLEAN_DIR="${DERIVS_DIR}/denoising-${afni_ver}"
mkdir -p ${CLEAN_DIR}
subject=$( sed -n -E "$((${SLURM_ARRAY_TASK_ID} + 1))s/sub-(\S*)\>.*/\1/gp" ${BIDS_DIR}/participants.tsv )
GSR=False
DM_SCANS=5
FD_THR=0.35
desc_clean="aCompCorCens"
desc_sm="aCompCorSM6Cens"
space="MNI152NLin2009cAsym"
SHELL_CMD="singularity exec --cleanenv \
    -B ${BIDS_DIR}:/data \
    -B ${CODE_DIR}:/code \
    -B ${MRIQC_DIR}:/mriqc \
    -B ${FMRIPREP_DIR}:/preproc \
    -B ${CLEAN_DIR}:/clean \
    $IMG_DIR/afni-${afni_ver}.sif"
denoising="${SHELL_CMD} python /code/denoising.py \
    --mriqc_dir /mriqc \
    --preproc_dir /preproc \
    --clean_dir /clean \
    --subject sub-${subject} \
    --space ${space} \
    --fd_thresh ${FD_THR} \
    --GSR ${GSR} \
    --dummy_scans ${DM_SCANS} \
    --desc_list ${desc_clean} ${desc_sm} \
    --n_jobs ${SLURM_CPUS_PER_TASK}"
echo
echo Commandline: $denoising
eval $denoising 
exitcode=$?
echo "sub-$subject   ${SLURM_ARRAY_TASK_ID}    $exitcode" \
      >> ${CODE_DIR}/log/${SLURM_JOB_NAME}/${DATA}/${SLURM_JOB_NAME}.${SLURM_ARRAY_JOB_ID}.tsv
echo Finished tasks ${SLURM_ARRAY_TASK_ID} with exit code $exitcode
date
exit $exitcode
