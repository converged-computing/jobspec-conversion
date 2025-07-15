#!/bin/bash
#FLUX: --job-name=mlpf-train-cms
#FLUX: -c=32
#FLUX: --gpus-per-task=8
#FLUX: --queue=small-g
#FLUX: -t=259200
#FLUX: --urgency=16

export IMG='/scratch/project_465000301/lumi-pytorch-rocm.simg'
export PYTHONPATH='hep_tfds'
export TFDS_DATA_DIR='/scratch/project_465000301/tensorflow_datasets'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export ROCM_PATH='/opt/rocm'

cd /scratch/project_465000301/particleflow
module load LUMI/22.08 partition/G
export IMG=/scratch/project_465000301/lumi-pytorch-rocm.simg
export PYTHONPATH=hep_tfds
export TFDS_DATA_DIR=/scratch/project_465000301/tensorflow_datasets
export MIOPEN_USER_DB_PATH=/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export ROCM_PATH=/opt/rocm
env
singularity exec --rocm \
  -B /scratch/project_465000301 \
  -B /tmp \
  --env PYTHONPATH=hep_tfds \
  $IMG python3 mlpf/pyg_pipeline.py --dataset cms --gpus $SLURM_GPUS_PER_TASK \
  --data-dir $TFDS_DATA_DIR --config parameters/pytorch/pyg-cms.yaml \
  --train \
  --conv-type attention --attention-type flash_external \
  --num-epochs 10 --gpu-batch-multiplier 4 --num-workers 1 --prefetch-factor 10 --checkpoint-freq 1
