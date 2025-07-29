#!/bin/bash
#SBATCH --job-name=mlpf-train-cms
#SBATCH --account=project_465000301
#SBATCH --output=logs/slurm-%x-%j-%N.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --gpus-per-task=8
#SBATCH --mem=130G
#SBATCH --time=3-00:00:00
#SBATCH --partition=small-g
#SBATCH --constraint=ntasks-per-node=1
#SBATCH: --no-requeue

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
