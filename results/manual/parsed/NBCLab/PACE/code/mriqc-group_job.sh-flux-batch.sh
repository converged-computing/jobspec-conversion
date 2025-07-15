#!/bin/bash
#FLUX: --job-name=mriqc
#FLUX: -c=4
#FLUX: --queue=bluemoon
#FLUX: -t=72000
#FLUX: --priority=16

pwd; hostname; date
set -e
module load singularity/3.7.1
mriqc_ver=0.16.1
DATA="COC"
HOST_DIR="/gpfs1/home/m/r/mriedel"
PROJECT="pace"
DSETS_DIR="${HOST_DIR}/${PROJECT}/dsets"
CODE_DIR="${HOST_DIR}/${PROJECT}/code"
BIDS_DIR="${DSETS_DIR}/dset-${DATA}"
IMG_DIR="${HOST_DIR}/${PROJECT}/software"
DERIVS_DIR="${BIDS_DIR}/derivatives/mriqc-${mriqc_ver}"
mkdir -p ${DERIVS_DIR}
SINGULARITY_CMD="singularity run --cleanenv \
      -B ${BIDS_DIR}:/data \
      -B ${DERIVS_DIR}:/out \
      ${IMG_DIR}/poldracklab-mriqc_${mriqc_ver}.sif"
mem_gb=`echo "${SLURM_MEM_PER_CPU} * ${SLURM_CPUS_PER_TASK} / 1024" | bc`
cmd="${SINGULARITY_CMD} /data \
      /out \
      group \
      --no-sub \
      --verbose-reports \
      --fd_thres 0.35 \
      --n_procs ${SLURM_CPUS_PER_TASK} \
      --mem_gb ${mem_gb}"
echo Commandline: $cmd
eval $cmd
exitcode=$?
SHELL_CMD="singularity exec --cleanenv \
      -B ${DERIVS_DIR}:/out \
      -B ${CODE_DIR}:/code \
      ${IMG_DIR}/poldracklab-mriqc_${mriqc_ver}.sif"
mriqc="${SHELL_CMD} python /code/mriqc-group.py \
          --dset /data \
          --out /out"
echo
echo Commandline: $mriqc
eval $mriqc 
exitcode=$?
echo "MRIQC-group $exitcode"
date
exit $exitcode
