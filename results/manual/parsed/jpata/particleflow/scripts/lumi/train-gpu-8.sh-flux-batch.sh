#!/bin/bash
#FLUX: --job-name=mlpf-train-cms
#FLUX: -c=16
#FLUX: --gpus-per-task=8
#FLUX: --queue=small-g
#FLUX: -t=259200
#FLUX: --priority=16

export IMG='/scratch/project_465000301/tf-rocm5.6-tf2.12.simg'
export PYTHONPATH='hep_tfds'
export TFDS_DATA_DIR='/scratch/project_465000301/tensorflow_datasets'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export TF_CPP_MAX_VLOG_LEVEL='-1 #to suppress ROCm fusion is enabled messages'
export ROCM_PATH='/opt/rocm'
export NCCL_DEBUG='WARN'
export MIOPEN_ENABLE_LOGGING='1'
export MIOPEN_ENABLE_LOGGING_CMD='1'
export MIOPEN_LOG_LEVEL='4'

cd /scratch/project_465000301/particleflow
module load LUMI/23.09 partition/G
export IMG=/scratch/project_465000301/tf-rocm5.6-tf2.12.simg
export PYTHONPATH=hep_tfds
export TFDS_DATA_DIR=/scratch/project_465000301/tensorflow_datasets
export MIOPEN_USER_DB_PATH=/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export TF_CPP_MAX_VLOG_LEVEL=-1 #to suppress ROCm fusion is enabled messages
export ROCM_PATH=/opt/rocm
export NCCL_DEBUG=WARN
export MIOPEN_ENABLE_LOGGING=1
export MIOPEN_ENABLE_LOGGING_CMD=1
export MIOPEN_LOG_LEVEL=4
singularity exec \
    --env LD_LIBRARY_PATH=/opt/rocm/lib/ \
    --rocm $IMG rocm-smi --showdriverversion --showmeminfo vram
singularity exec \
    --rocm \
    -B /scratch/project_465000301 \
    -B /tmp \
    --env LD_LIBRARY_PATH=/opt/rocm/lib/ \
    $IMG python3 mlpf/pipeline.py train \
    --config parameters/cms-gen.yaml --plot-freq 1 --num-cpus 8 \
    --batch-multiplier 2 --plot-freq -1 --weights experiments/cms-gen_20240108_154245_299103.nid005026/weights/weights-05-4.250307.hdf5
