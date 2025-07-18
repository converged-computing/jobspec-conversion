#!/bin/bash
#FLUX: --job-name=angry-bits-5582
#FLUX: --exclusive
#FLUX: -t=28800
#FLUX: --urgency=16

set -eux
curr_dt=`date +"%Y-%m-%d-%H-%M-%S"`
readonly ro_mounts="${checkpointdir}:/workspace/checkpoints,${datadir}:/workspace/coco"
CREATE_FOLDER_CMD="mkdir -p /tmp/convergence-FP32-32xV100-32G; chmod -R 02775 /tmp/convergence-FP32-32xV100-32G"
srun --ntasks="${SLURM_JOB_NUM_NODES}" --ntasks-per-node=1 sh -c "${CREATE_FOLDER_CMD}"
bs=40
ep=350
lr=1.0
wu=90
ema=0.999
momentum=0.95
EFFDET_CMD="\
        python3 train.py \
        --training_mode=${training_mode:=traineval} \
        --training_file_pattern=/workspace/coco/train-* \
        --val_file_pattern=/workspace/coco/val-* \
        --val_json_file=/workspace/coco/annotations/instances_val2017.json \
        --model_name=efficientdet-d0 \
        --model_dir=/tmp/convergence-FP32-32xV100-32G  \
        --backbone_init=/workspace/checkpoints/efficientnet-b0-joc \
        --batch_size=$bs \
        --eval_batch_size=$bs \
        --num_epochs=$ep \
        --use_xla=True \
        --amp=False \
        --lr=$lr \
        --warmup_epochs=$wu \
        --hparams="moving_average_decay=$ema,momentum=$momentum" \
        2>&1 | tee /tmp/convergence-FP32-32xV100-32G/train-$curr_dt.log"
srun --mpi=pmix -l --container-image=nvcr.io/nvidia/effdet:21.09-tf2 --no-container-entrypoint --container-mounts="${ro_mounts}" bash -c "${EFFDET_CMD}"
