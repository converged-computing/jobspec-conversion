#!/bin/bash
#FLUX: --job-name=generate_no_tp
#FLUX: -c=4
#FLUX: --urgency=16

export TORCH_EXTENSIONS_DIR='${ROOT_DIR}/torch_extendsions'
export PL_DEEPSPEED_CONFIG_PATH='$CONFIG_JSON'
export options=' \'

ROOT_DIR=../../workspace
export TORCH_EXTENSIONS_DIR=${ROOT_DIR}/torch_extendsions
MODEL_NAME=finetune_ziya_llama13b
MODEL_ROOT_DIR=$ROOT_DIR/${MODEL_NAME}
if [ ! -d ${MODEL_ROOT_DIR} ];then
  mkdir -p ${MODEL_ROOT_DIR}
fi
NNODES=1
GPUS_PER_NODE=1
MICRO_BATCH_SIZE=1
CONFIG_JSON="$MODEL_ROOT_DIR/${MODEL_NAME}.ds_config.json"
ZERO_STAGE=2
cat <<EOT > $CONFIG_JSON
{
    "zero_optimization": {
        "stage": ${ZERO_STAGE}
    },
    "fp16": {
        "enabled": true
    },
    "activation_checkpointing": {
      "partition_activations": true,
      "contiguous_memory_optimization": true,
      "number_checkpoints": 20
    },
    "gradient_clipping": 1,
    "train_micro_batch_size_per_gpu": $MICRO_BATCH_SIZE
}
EOT
export PL_DEEPSPEED_CONFIG_PATH=$CONFIG_JSON
DATA_ARGS="\
        --dataloader_workers 2 \
        --train_batchsize $MICRO_BATCH_SIZE  \
        --val_batchsize $MICRO_BATCH_SIZE \
        --test_batchsize $MICRO_BATCH_SIZE  \
        --train_file ../../workspace/finetune_ziya_llama13b/data/small_test.json \
        --val_file ../../workspace/finetune_ziya_llama13b/data/small_test.json \
        --test_file ../../workspace/finetune_ziya_llama13b/data/small_test.json \
        --use_mpu \
        --do_eval_only \
        "
MODEL_ARGS="\
        --model_path ../../workspace/finetune_ziya_llama13b/llama13b_fs \
        --tokenizer_path ../../workspace/finetune_ziya_llama13b/llama13b_fs \
        --learning_rate 1e-4 \
        --min_learning_rate 1e-5 \
        --weight_decay 0.1 \
        --warmup_ratio 0.05 \
        --adam_beta1 0.9 \
        --adam_beta2 0.95 \
        --max_seq_length 256 \
        --model_parallel_size 1 \
        --load_ckpt_path ../../workspace/finetune_ziya_llama13b/ckpt_no_tp/model-epepoch=08-ststep=500.ckpt \
        "
MODEL_CHECKPOINT_ARGS="\
        --save_last \
        --every_n_train_steps 16000 \
        --save_ckpt_path ${MODEL_ROOT_DIR}/ckpt \
        "
TRAINER_ARGS="\
        --max_epoch 1 \
        --gpus $GPUS_PER_NODE \
        --num_nodes $NNODES \
        --log_every_n_steps 5 \
        --precision 16 \
        --accumulate_grad_batches 1 \
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
srun python3 finetune_ziya_llama.py $options
