#!/bin/bash
#FLUX: --job-name=qcfc
#FLUX: -c=4
#FLUX: --queue=bluemoon
#FLUX: -t=104400
#FLUX: --urgency=16

pwd; hostname; date
set -e
spack load singularity@3.7.1
DATA="COC"
HOST_DIR="/gpfs1/home/m/r/mriedel"
PROJECT="pace"
DSETS_DIR="${HOST_DIR}/${PROJECT}/dsets"
CODE_DIR="${DSETS_DIR}/code"
BIDS_DIR="${DSETS_DIR}/dset-${DATA}"
IMG_DIR="${HOST_DIR}/${PROJECT}/software"
DERIVS_DIR="${BIDS_DIR}/derivatives"
mriqc_ver=0.16.1
fmriprep_ver=20.2.5
afni_ver=22.0.20
MRIQC_DIR="${DERIVS_DIR}/mriqc-${mriqc_ver}"
FMRIPREP_DIR="${DERIVS_DIR}/fmriprep-${fmriprep_ver}/fmriprep"
CLEAN_DIR="${DERIVS_DIR}/denoising-${afni_ver}"
QCFC_DIR="${DERIVS_DIR}/qcfc"
mkdir -p ${QCFC_DIR}
FD_THR=0.35
DM_SCANS=5
desc_clean="aCompCorCens"
desc_sm="aCompCorSM6Cens"
space="MNI152NLin2009cAsym"
SHELL_CMD="singularity exec --cleanenv \
    -B ${BIDS_DIR}:/data \
    -B ${CODE_DIR}:/code \
    -B ${MRIQC_DIR}:/mriqc \
    -B ${FMRIPREP_DIR}:/preproc \
    -B ${CLEAN_DIR}:/clean \
    -B ${QCFC_DIR}:/qcfc \
    $IMG_DIR/afni-${afni_ver}.sif"
qcfc="${SHELL_CMD} python /code/qcfc.py \
    --dset /data \
    --mriqc_dir /mriqc \
    --preproc_dir /preproc \
    --clean_dir /clean \
    --qcfc_dir /qcfc \
    --space ${space} \
    --qc_thresh ${FD_THR} \
    --dummy_scans ${DM_SCANS} \
    --desc_list ${desc_clean} ${desc_sm} \
    --n_jobs ${SLURM_CPUS_PER_TASK}"
echo
echo Commandline: $qcfc
eval $qcfc 
exitcode=$?
date
exit $exitcode
