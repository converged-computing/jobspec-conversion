#!/bin/bash
#FLUX: --job-name=adorable-ricecake-8670
#FLUX: -c=12
#FLUX: --queue=gpu
#FLUX: -t=7200
#FLUX: --priority=16

APPTAINER_IMAGE_PATH=/mnt/parscratch/users/$USER/pytorch-transformers-wikitext2-benchmark/transformers-benchmark-23.07.sif 
echo "HOSTNAME=${HOSTNAME}"
nvidia-smi
nproc
apptainer run -c -e --bind $(pwd):/mnt --bind ${TMPDIR}:/tmp --env "HF_HOME=/mnt/hf_home/${SLURM_JOB_ID}" --env "TMPDIR=/tmp/${SLURM_JOB_ID}" --nv ${APPTAINER_IMAGE_PATH}
