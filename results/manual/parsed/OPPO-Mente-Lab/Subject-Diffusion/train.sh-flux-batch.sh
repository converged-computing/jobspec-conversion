#!/bin/bash
#FLUX: --job-name=finetune_oppo
#FLUX: -c=30
#FLUX: --urgency=16

export CPATH='/usr/local/cuda/include:$CPATH'
export LD_LIBRARY_PATH='/usr/local/cuda/lib64:$LD_LIBRARY_PATH'
export PATH='/usr/local/cuda/bin:$PATH'
export NCCL_P2P_LEVEL='NVL'
export NCCL_IB_DISABLE='1'
export PL_DEEPSPEED_CONFIG_PATH='$CONFIG_JSON'
export options=' \'
export CC='gcc'
export CXX='g++'

export CPATH=/usr/local/cuda/include:$CPATH
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
export PATH=/usr/local/cuda/bin:$PATH
export NCCL_P2P_LEVEL=NVL
export NCCL_IB_DISABLE=1
ROOT_DIR=/public_data/ma/code/GLIGEN-master/results_mul
MODEL_NAME=glyphdraw_multi_2
MODEL_ROOT_DIR=$ROOT_DIR/${MODEL_NAME}
if [ ! -d ${MODEL_ROOT_DIR} ];then
  mkdir ${MODEL_ROOT_DIR}
fi
MICRO_BATCH_SIZE=8
GPUS_PER_NODE=$2
NNODES=4
CONFIG_JSON="$MODEL_ROOT_DIR/${MODEL_NAME}.ds_config.json"
ZERO_STAGE=1
cat <<EOT > $CONFIG_JSON
{
    "zero_optimization": {
        "stage": ${ZERO_STAGE}
    },
    "train_micro_batch_size_per_gpu": $MICRO_BATCH_SIZE
}
EOT
export PL_DEEPSPEED_CONFIG_PATH=$CONFIG_JSON
        # /public_data/ma/data_process/aesthetics_tar_sam/{00000..26000}.tar \
        # /public_data/ma/data_process/BLIP_tar_512_sam/{00000..12068}.tar \
DATA_ARGS="\
        --webdataset_base_urls \
        /public_data/ma/data_process/aesthetics_tar_sam/{00000..44487}.tar \
        --num_workers 2 \
        --batch_size $MICRO_BATCH_SIZE \
        --shard_width 5 \
        --hr_size 512 \
        --train_split 1.0 \
        --val_split 0.0 \
        --test_split 0.0 \
        --resample_train \
        "
MODEL_ARGS="\
        --model_path /public_data/ma/stable_models/model_base \
        --learning_rate 3e-5 \
        --weight_decay 0 \
        --warmup_steps 1000 \
        "
MODEL_CHECKPOINT_ARGS="\
        --save_last \
        --save_ckpt_path ${MODEL_ROOT_DIR}/ckpt \
        --load_ckpt_path ${MODEL_ROOT_DIR}/ckpt/last.ckpt \
        "
TRAINER_ARGS="\
        --max_epoch 10 \
        --accelerator gpu \
        --devices $GPUS_PER_NODE \
        --num_nodes $NNODES \
        --strategy deepspeed_stage_${ZERO_STAGE} \
        --log_every_n_steps 100 \
        --precision 16 \
        --default_root_dir ${MODEL_ROOT_DIR} \
        --replace_sampler_ddp False \
        --num_sanity_val_steps 0 \
        --limit_val_batches 0 \
        "
export options=" \
        $DATA_ARGS \
        $MODEL_ARGS \
        $MODEL_CHECKPOINT_ARGS \
        $TRAINER_ARGS \
        "
export CC=gcc
export CXX=g++
python -m torch.distributed.run \
    --nnodes $NNODES \
    --master_addr 10.25.193.83 \
    --master_port 29500 \
    --node_rank $1 \
    --nproc_per_node $GPUS_PER_NODE \
    train.py $options
