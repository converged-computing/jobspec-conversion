#!/bin/bash
#FLUX: --job-name=fugly-gato-5012
#FLUX: --queue=gh
#FLUX: -t=3600
#FLUX: --urgency=16

APPTAINER_IMAGE_PATH=/nobackup/projects/${SLURM_JOB_ACCOUNT}/${USER}/aarch64/pytorch-transformers-wikitext2-benchmark/transformers-benchmark-23.07.sif 
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
nproc
apptainer run -c -e --bind $(pwd):/mnt --bind ${TMPDIR}:/tmp --env "HF_HOME=/mnt/hf_home/${SLURM_JOB_ID}" --env "TMPDIR=/tmp/${SLURM_JOB_ID}" --nv ${APPTAINER_IMAGE_PATH}
