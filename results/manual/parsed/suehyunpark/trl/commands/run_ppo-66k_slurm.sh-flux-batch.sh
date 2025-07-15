#!/bin/bash
#FLUX: --job-name=mpa-Mistral-7b-v0.2-hf-ppo-66k
#FLUX: --queue=LocalQ
#FLUX: -t=86400
#FLUX: --urgency=16

export WANDB_API_KEY='xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
export HF_TOKEN='hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'
export WANDB_PROJECT='mpa-rm'
export WANDB_ENTITY='suehyun'
export NCCL_IB_GID_INDEX='3'
export NCCL_P2P_LEVEL='NVL'

export WANDB_API_KEY="xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export HF_TOKEN="hf_xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
export WANDB_PROJECT="mpa-rm"
export WANDB_ENTITY="suehyun"
export NCCL_IB_GID_INDEX=3
export NCCL_P2P_LEVEL=NVL
OUTPUT_DIR="outputs/mpa-Mistral-7b-v0.2-hf-ppo-66k"
MODEL_NAME="/mnt/nas/suehyun/axolotl/outputs/mpa/mpa-Mistral-7b-v0.2-hf-sft-epoch1"
REWARD_MODEL_NAME="kaist-ai/mpa-Mistral-7b-v0.2-hf-rm-66k"
TRAIN_FILE="/mnt/nas/suehyun/MPA/data/train/preferences_v1_responses_for_orpo_64k_v2_ppo.jsonl"
EVAL_FILE="/mnt/nas/suehyun/MPA/data/test/mpa_rm_test_set_w_rubric_per_preference.json"
EPOCHS=3
BATCH_SIZE=4
SEQ_LEN=4096
LR="1.41e-5"  # InstructGPT
HUB_MODEL_ID="kaist-ai/mpa-Mistral-7b-v0.2-hf-ppo-66k"
RUN_NAME="mpa-Mistral-7b-v0.2-hf-ppo-66k"
EXTRA_ACCELERATE_ARGS="--config_file examples/accelerate_configs/deepspeed_zero2.yaml"
DATA_CONFIG_ARGS = """--max_length $SEQ_LEN \
  --repo_id $HUB_MODEL_ID \
  --run_name $RUN_NAME \
  --output_dir $OUTPUT_DIR \
  --save_steps 500
"""
PPO_CONFIG_ARGS="""--exp_name $RUN_NAME \
  --seed 42 \
  --log_with wandb \
  --model_name $MODEL_NAME \
  --reward_model $REWARD_MODEL_NAME \
  --query_dataset $TRAIN_FILE \
  --remove_unused_columns True \
  --learning_rate $LR \
  --batch_size $BATCH_SIZE \
  --mini_batch_size $BATCH_SIZE \
  --gradient_accumulation_steps 1 \
  --ppo_epochs $EPOCHS \
  --optimize_device_cache True \
  --tracker_project_name $WANDB_PROJECT \
  --trust_remote_code True"""
srun accelerate launch $EXTRA_ACCELERATE_ARGS \
    examples/scripts/mpa/ppo.py \
    $DATA_CONFIG_ARGS \
    $PPO_CONFIG_ARGS
