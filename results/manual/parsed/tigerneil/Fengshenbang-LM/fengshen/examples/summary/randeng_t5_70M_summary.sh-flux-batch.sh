#!/bin/bash
#FLUX: --job-name=randeng_t5_77M_summary
#FLUX: -c=30
#FLUX: --urgency=16

export PL_DEEPSPEED_CONFIG_PATH='$config_json'
export TORCH_EXTENSIONS_DIR='/cognitive_comp/ganruyi/tmp/torch_extendsions'
export MASTER_PORT='$[RANDOM%10000+30000]'
export CMD=' \'

set -x -e
echo "START TIME: $(date)"
MODEL_NAME=randeng_t5_77M_summary_test2
MICRO_BATCH_SIZE=64
ROOT_DIR=/cognitive_comp/ganruyi/experiments/${MODEL_NAME}
if [ ! -d ${ROOT_DIR} ];then
  mkdir ${ROOT_DIR}
  echo ${ROOT_DIR} created!!!!!!!!!!!!!!
else
  echo ${ROOT_DIR} exist!!!!!!!!!!!!!!!
fi
ZERO_STAGE=1
config_json="${ROOT_DIR}/ds_config.${MODEL_NAME}.json"
cat <<EOT > $config_json
{
  "train_micro_batch_size_per_gpu": ${MICRO_BATCH_SIZE},
  "steps_per_print": 100,
  "gradient_clipping": 1.0,
  "zero_optimization": {
    "stage": $ZERO_STAGE,
    "contiguous_gradients": false,
    "overlap_comm": true,
    "reduce_scatter": true,
    "reduce_bucket_size": 50000000,
    "allgather_bucket_size": 500000000
  },
  "optimizer": {
    "type": "Adam",
    "params": {
      "lr": 1e-4,
      "weight_decay": 1e-2
    }
  },
  "scheduler": {
    "params": {
      "warmup_max_lr": 1e-04,
      "warmup_min_lr": 1e-05,
      "total_num_steps": 60000,
      "warmup_num_steps" : 500
    },
    "type": "WarmupDecayLR"  
  },
  "zero_allow_untested_optimizer": false,
  "fp16": {
    "enabled": true,
    "loss_scale": 0,
    "loss_scale_window": 1000,
    "hysteresis": 2,
    "min_loss_scale": 1
  },
  "activation_checkpointing": {
    "partition_activations": false,
    "contiguous_memory_optimization": false
  },
  "wall_clock_breakdown": false
}
EOT
export PL_DEEPSPEED_CONFIG_PATH=$config_json
export TORCH_EXTENSIONS_DIR=/cognitive_comp/ganruyi/tmp/torch_extendsions
export MASTER_PORT=$[RANDOM%10000+30000]
TRAINER_ARGS="
    --max_epochs 2 \
    --gpus 2 \
    --num_nodes 1 \
    --strategy deepspeed_stage_${ZERO_STAGE} \
    --default_root_dir $ROOT_DIR \
    --dirpath $ROOT_DIR/ckpt \
    --save_top_k 3 \
    --monitor train_loss \
    --mode min \
    --save_last \
    --every_n_train_steps 0 \
    --val_check_interval 0.5 \
"
DATA_DIR=/cognitive_comp/ganruyi/data_datasets_LCSTS_LCSTS/
prompt="summary:"
DATA_ARGS="
    --data_dir $DATA_DIR
    --train_batchsize $MICRO_BATCH_SIZE \
    --valid_batchsize $MICRO_BATCH_SIZE \
    --train_data train.jsonl\
    --valid_data valid.jsonl\
    --test_data  valid.jsonl\
"
MODEL_ARGS="
    --pretrained_model_path /cognitive_comp/ganruyi/experiments/randeng_t5_77M/ckpt/hf_pretrained_epoch0_step183100 \
    --output_save_path $ROOT_DIR/randeng_t5_77M_predict_lcsts.json \
"
SCRIPTS_PATH=/cognitive_comp/ganruyi/Fengshenbang-LM/fengshen/examples/summary/seq2seq_summary.py
SINGULARITY_PATH=/cognitive_comp/ganruyi/pytorch21_06_py3_docker_image_v2.sif
export CMD=" \
    $SCRIPTS_PATH \
    $TRAINER_ARGS \
    $MODEL_ARGS \
    $DATA_ARGS \
    "
echo $CMD
source activate base
srun --jobid=171866 --nodes=1 --gres=gpu:2 --ntasks-per-node=2 --cpus-per-task=30 -e randeng_t5_77M_summary-%j.err -o randeng_t5_77M_summary-%j.log singularity exec --nv -B /cognitive_comp/:/cognitive_comp/ $SINGULARITY_PATH bash -c '/home/ganruyi/anaconda3/bin/python $CMD'
