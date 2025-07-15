#!/bin/bash
#FLUX: --job-name=mlpf-train-clic-hits-ln-full
#FLUX: -c=8
#FLUX: --gpus-per-task=2
#FLUX: --queue=small-g
#FLUX: -t=86400
#FLUX: --priority=16

export IMG='/scratch/project_465000301/tf-rocm.simg'
export PYTHONPATH='hep_tfds'
export TFDS_DATA_DIR='/scratch/project_465000301/tensorflow_datasets'
export MIOPEN_USER_DB_PATH='/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache'
export MIOPEN_CUSTOM_CACHE_DIR='${MIOPEN_USER_DB_PATH}'
export TF_CPP_MAX_VLOG_LEVEL='-1 #to suppress ROCm fusion is enabled messages'

cd /scratch/project_465000301/particleflow
module load LUMI/22.08 partition/G
export IMG=/scratch/project_465000301/tf-rocm.simg
export PYTHONPATH=hep_tfds
export TFDS_DATA_DIR=/scratch/project_465000301/tensorflow_datasets
export MIOPEN_USER_DB_PATH=/tmp/${USER}-${SLURM_JOB_ID}-miopen-cache
export MIOPEN_CUSTOM_CACHE_DIR=${MIOPEN_USER_DB_PATH}
export TF_CPP_MAX_VLOG_LEVEL=-1 #to suppress ROCm fusion is enabled messages
singularity exec \
    --rocm \
    -B /scratch/project_465000301 \
    -B /tmp \
    --env LD_LIBRARY_PATH=/opt/rocm/lib/ \
    $IMG python3 mlpf/pipeline.py train \
    --config parameters/clic-test.yaml --plot-freq 1 --num-cpus 8 \
    --batch-multiplier 5 --ntrain 50000 --ntest 50000 --benchmark_dir exp_dir
