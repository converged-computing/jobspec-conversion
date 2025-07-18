#!/bin/bash
#FLUX: --job-name=zen2_base_cluener
#FLUX: -c=30
#FLUX: --urgency=16

export TORCH_EXTENSIONS_DIR='/cognitive_comp/ganruyi/tmp/torch_extendsions'

export TORCH_EXTENSIONS_DIR=/cognitive_comp/ganruyi/tmp/torch_extendsions
MODEL_NAME=zen2_base
TASK=cluener
ZERO_STAGE=1
STRATEGY=deepspeed_stage_${ZERO_STAGE}
ROOT_DIR=/cognitive_comp/ganruyi/experiments/ner_finetune/${MODEL_NAME}_${TASK}
if [ ! -d ${ROOT_DIR} ];then
  mkdir -p ${ROOT_DIR}
  echo ${ROOT_DIR} created!!!!!!!!!!!!!!
else
  echo ${ROOT_DIR} exist!!!!!!!!!!!!!!!
fi
DATA_DIR=/cognitive_comp/lujunyu/data_zh/NER_Aligned/CLUENER/
PRETRAINED_MODEL_PATH=/cognitive_comp/ganruyi/hf_models/zen/zh_zen_base_2.0
CHECKPOINT_PATH=${ROOT_DIR}/ckpt/
OUTPUT_PATH=${ROOT_DIR}/predict.json
DATA_ARGS="\
        --data_dir $DATA_DIR \
        --train_data train.char.txt \
        --valid_data dev.char.txt \
        --test_data dev.char.txt \
        --train_batchsize 32 \
        --valid_batchsize 16 \
        --max_seq_length 256 \
        --task_name cluener \
        "
MODEL_ARGS="\
        --learning_rate 3e-5 \
        --weight_decay 0.1 \
        --warmup_ratio 0.01 \
        --markup bio \
        --middle_prefix I- \
        "
MODEL_CHECKPOINT_ARGS="\
        --monitor val_f1 \
        --save_top_k 3 \
        --mode max \
        --every_n_train_steps 100 \
        --save_weights_only True \
        --dirpath $CHECKPOINT_PATH \
        --filename model-{epoch:02d}-{val_f1:.4f} \
        "
TRAINER_ARGS="\
        --max_epochs 30 \
        --gpus 1 \
        --check_val_every_n_epoch 1 \
        --val_check_interval 100 \
        --default_root_dir $ROOT_DIR \
        "
options=" \
        --pretrained_model_path $PRETRAINED_MODEL_PATH \
        --vocab_file $PRETRAINED_MODEL_PATH/vocab.txt \
        --do_lower_case \
        --output_save_path $OUTPUT_PATH \
        $DATA_ARGS \
        $MODEL_ARGS \
        $MODEL_CHECKPOINT_ARGS \
        $TRAINER_ARGS \
"
SCRIPT_PATH=/cognitive_comp/ganruyi/Fengshenbang-LM/fengshen/examples/zen2_finetune/fengshen_token_level_ft_task.py
/home/ganruyi/anaconda3/bin/python $SCRIPT_PATH $options
