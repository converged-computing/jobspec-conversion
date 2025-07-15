#!/bin/bash
#FLUX: --job-name=mlpf-train-cms
#FLUX: -c=16
#FLUX: --gpus-per-task=1
#FLUX: --queue=small-g
#FLUX: -t=259200
#FLUX: --priority=16

export IMG='/scratch/project_465000301/tf-rocm5.6-tf2.12-2024-01-11.simg'
export PYTHONPATH='hep_tfds'
export TFDS_DATA_DIR='/scratch/project_465000301/tensorflow_datasets'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export TF_CPP_MAX_VLOG_LEVEL='-1 #to suppress ROCm fusion is enabled messages'
export ROCM_PATH='/opt/rocm'
export NCCL_DEBUG='WARN'

cd /scratch/project_465000301/particleflow
module load LUMI/22.08 partition/G
export IMG=/scratch/project_465000301/tf-rocm5.6-tf2.12-2024-01-11.simg
export PYTHONPATH=hep_tfds
export TFDS_DATA_DIR=/scratch/project_465000301/tensorflow_datasets
export MIOPEN_USER_DB_PATH=/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export TF_CPP_MAX_VLOG_LEVEL=-1 #to suppress ROCm fusion is enabled messages
export ROCM_PATH=/opt/rocm
export NCCL_DEBUG=WARN
singularity exec \
    --env LD_LIBRARY_PATH=/opt/rocm/lib/ \
    --rocm $IMG rocm-smi --showdriverversion --showmeminfo vram
singularity exec \
    --rocm \
    -B /scratch/project_465000301 \
    -B /tmp \
    --env LD_LIBRARY_PATH=/opt/rocm/lib/ \
    $IMG python3.9 mlpf/pipeline.py hypertune --config parameters/bench/clic-hits-bench.yaml --ntrain 100 --ntest 100 -o hypertuning_100
