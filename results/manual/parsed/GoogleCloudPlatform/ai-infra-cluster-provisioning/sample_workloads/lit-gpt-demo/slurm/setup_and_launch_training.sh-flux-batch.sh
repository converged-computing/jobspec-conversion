#!/bin/bash
#FLUX: --job-name=fat-punk-6465
#FLUX: -N=4
#FLUX: --exclusive
#FLUX: --queue=a3
#FLUX: --urgency=16

export MODEL_NAME='                               #'Llama-2-70b-hf'
export GCS_EXPERIMENT_BUCKET='                    # myBucket'
export EXPERIMENT_ROOT_DIR='                      # llama-2/training_logs'
export UDS_PATH='/run/tcpx-${SLURM_JOB_ID}'

export MODEL_NAME=                               #'Llama-2-70b-hf'
export GCS_EXPERIMENT_BUCKET=                    # myBucket
export EXPERIMENT_ROOT_DIR=                      # llama-2/training_logs
export UDS_PATH="/run/tcpx-${SLURM_JOB_ID}"
srun --ntasks-per-node=1 \
    gcloud auth configure-docker us-central1-docker.pkg.dev
srun -l --ntasks-per-node=1 bash litgpt_container.sh
