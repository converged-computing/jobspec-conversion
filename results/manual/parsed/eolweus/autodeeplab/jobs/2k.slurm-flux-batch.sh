#!/bin/bash
#FLUX: --job-name="2k"
#FLUX: -c=4
#FLUX: --queue=GPUQ
#FLUX: -t=86400
#FLUX: --priority=16

export PYTHONBUFFERED='1'

WORKDIR=${SLURM_SUBMIT_DIR}
cd ${WORKDIR}
echo "we are running from this directory: $SLURM_SUBMIT_DIR"
echo " the name of the job is: $SLURM_JOB_NAME"
echo "Th job ID is $SLURM_JOB_ID"
echo "The job was run on these nodes: $SLURM_JOB_NODELIST"
echo "Number of nodes: $SLURM_JOB_NUM_NODES"
echo "We are using $SLURM_CPUS_ON_NODE cores"
echo "We are using $SLURM_CPUS_ON_NODE cores per node"
echo "Total of $SLURM_NTASKS cores"
if [[ $GPU_MEMORY -gt 80000 ]]; then
    BATCH_SIZE=22
else
    BATCH_SIZE=12
fi
module purge
source ~/.bashrc
module load CUDA/11.3.1
conda activate autodl
export PYTHONBUFFERED=1
CUDA_VISIBLE_DEVICES=0 python ../train_autodeeplab.py \
  --batch_size $BATCH_SIZE \
  --dataset solis \
  --checkname "corr_2040_s21" \
  --alpha_epoch 20 \
  --filter_multiplier 8 \
  --resize 224 \
  --crop_size 224 \
  --num_bands 12 \
  --epochs 40 \
  --num_images 2040 \
  --loss-type ce \
  --use_ab true \
  --seed 21
uname -a 
