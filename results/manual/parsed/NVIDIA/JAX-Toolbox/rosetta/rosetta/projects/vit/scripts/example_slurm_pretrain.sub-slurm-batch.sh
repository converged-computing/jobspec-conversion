#!/bin/bash
#FLUX: --job-name=jobname
#FLUX: --exclusive
#FLUX: --queue=partition
#FLUX: -t=14400
#FLUX: --urgency=16

set -x
CONTAINER="${CONTAINER:=ghcr.io/nvidia/t5x:vit-2023-07-21}"
BASE_WORKSPACE_DIR=${BASE_WORKSPACE_DIR} # path to workspace directory where outputs will reside
BASE_WDS_DATA_DIR=${BASE_WDS_DATA_DIR} # path to imagenet dataset
BASE_TRAIN_IDX_DIR=${BASE_TRAIN_IDX_DIR} # path to train indices (if any)
BASE_EVAL_IDX_DIR=${BASE_EVAL_IDX_DIR} # path to eval indices (if any)
WORKSPACE_DIR=/opt/rosetta/workspace
WDS_DATA_DIR=/opt/rosetta/datasets/imagenet
TRAIN_IDX_DIR=/opt/rosetta/train_idxs
EVAL_IDX_DIR=/opt/rosetta/eval_idxs
MOUNTS="--container-mounts=$BASE_WORKSPACE_DIR:$WORKSPACE_DIR,$BASE_WDS_DATA_DIR:/$WDS_DATA_DIR,$BASE_TRAIN_IDX_DIR:$TRAIN_IDX_DIR,$BASE_EVAL_IDX_DIR:$EVAL_IDX_DIR"
EXPORTS="--export=ALL,WORKSPACE_DIR=${WORKSPACE_DIR},WDS_DATA_DIR=${WDS_DATA_DIR},TRAIN_IDX_DIR=${TRAIN_IDX_DIR},EVAL_IDX_DIR=${EVAL_IDX_DIR}"
VIT_SIZE=${VIT_SIZE:="base"}          # base
PREC=${PREC:="bfloat16"}            # bfloat16, float32
GPUS_PER_NODE=${GPUS_PER_NODE:=8}    # usually 8
BSIZE_PER_GPU=${BSIZE_PER_GPU:=512}     # local batch size/gpu
MODEL_DIR_LOCAL=${MODEL_DIR_LOCAL:="pretrain_dir"}   # directory to save checkpoints and config dump to, relative to BASE_WORKSPACE_DIR
GRAD_ACCUM=${GRAD_ACCUM:=1}
read -r -d '' cmd <<EOF
echo "*******STARTING********" \
&& nvidia-smi \
&& bash rosetta/projects/vit/scripts/multiprocess_pretrain.sh $VIT_SIZE $PREC $GPUS_PER_NODE $BSIZE_PER_GPU workspace/$MODEL_DIR_LOCAL $TRAIN_IDX_DIR $EVAL_IDX_DIR $GRAD_ACCUM
EOF
OUTPUT_DIR="${BASE_WORKSPACE_DIR}/outputs/pretrain-${VIT_SIZE}-${PREC}-N${SLURM_JOB_NUM_NODES}-n${GPUS_PER_NODE}-BS${BSIZE_PER_GPU}"
mkdir -p ${OUTPUT_DIR}
OUTFILE="${OUTPUT_DIR}/output-%j-%n-%t.txt"
echo $cmd
srun -o $OUTFILE -e $OUTFILE --container-image="$CONTAINER" $MOUNTS $EXPORTS bash -c "${cmd}"
