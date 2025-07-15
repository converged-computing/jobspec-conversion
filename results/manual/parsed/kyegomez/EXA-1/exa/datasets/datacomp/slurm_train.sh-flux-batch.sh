#!/bin/bash
#FLUX: --job-name=<job_name>
#FLUX: -c=6
#FLUX: --queue=<partition_name>
#FLUX: --priority=16

export PYTHONFAULTHANDLER='1'
export CUDA_LAUNCH_BLOCKING='0'
export HOSTNAMES='`scontrol show hostnames "$SLURM_JOB_NODELIST"`'
export MASTER_ADDR='$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)'
export MASTER_PORT='12802'
export COUNT_NODE='`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`'

module load openmpi
export PYTHONFAULTHANDLER=1
export CUDA_LAUNCH_BLOCKING=0
export HOSTNAMES=`scontrol show hostnames "$SLURM_JOB_NODELIST"`
export MASTER_ADDR=$(scontrol show hostnames "$SLURM_JOB_NODELIST" | head -n 1)
export MASTER_PORT=12802
export COUNT_NODE=`scontrol show hostnames "$SLURM_JOB_NODELIST" | wc -l`
echo go $COUNT_NODE
echo $HOSTNAMES
DATA_PATH="/path/to/data/dir"
SCALE="small"
SEED=0
OUTPUT_DIR="/path/to/output/dir"
NUM_CHECKPOINTS=8
EXP_NAME="datacomp-scale-${SCALE}-seed${SEED}"
PRECISION="amp"  # You can also use amp_bfloat16 if supported by your hardware.
srun --comment "<comment>" --cpu_bind=v --accel-bind=gn python train.py \
    --scale ${SCALE} \
    --data_dir ${DATA_PATH} \
    --output_dir ${OUTPUT_DIR} \
    --exp_name ${EXP_NAME} \
    --precision ${PRECISION} \
    --num_checkpoints ${NUM_CHECKPOINTS} \
    --seed ${SEED} \
    --report_to_wandb \
    --dataset_resampled \
    --accum_freq 1 
