#!/bin/bash
#FLUX: --job-name=glue
#FLUX: -c=4
#FLUX: --queue=gpu
#FLUX: -t=172800
#FLUX: --urgency=16

export TRANSFORMERS_CACHE='checkpoints/hf_model'
export HF_DATASETS_CACHE='checkpoints/hf_model'
export HF_METRICS_CACHE='checkpoints/hf_model'
export TASK_NAME='rte'
export WANDB_ENTITY='adapter-merge'
export WANDB_PROJECT='prompt_glue.${TASK_NAME}'
export WANDB_WATCH='all'
export CUDA_VISIBLE_DEVICES='2,3'

trap_handler () {
   echo "Caught signal: " $1
   # SIGTERM must be bypassed
   if [ "$1" = "TERM" ]; then
       echo "bypass sigterm"
   else
     # Submit a new job to the queue
     echo "Requeuing " $SLURM_ARRAY_JOB_ID $SLURM_ARRAY_TASK_ID
     # SLURM_JOB_ID is a unique representation of the job, equivalent
     # to above
     scontrol requeue $SLURM_JOB_ID
   fi
}
trap 'trap_handler USR1' USR1
trap 'trap_handler TERM' TERM
export TRANSFORMERS_CACHE=checkpoints/hf_model
export HF_DATASETS_CACHE=checkpoints/hf_model
export HF_METRICS_CACHE=checkpoints/hf_model
cache_dir=${TRANSFORMERS_CACHE}
export TASK_NAME=rte
metric="accuracy"
adapter_config="ia3"
export WANDB_ENTITY="adapter-merge"
export WANDB_PROJECT=prompt_glue.${TASK_NAME}
export WANDB_WATCH="all"
report_to="none"
export CUDA_VISIBLE_DEVICES=2,3
nodes_num=2
DATE=`date +%Y%m%d`
debug=0
bsz=4
gradient_steps=1
lr=5e-4
max_grad_norm=1
weight_decay=0.01
warmup_updates=0
warmup_ratio=0.06
max_steps=150
num_train_epochs=10
max_tokens_per_batch=0
max_seq_length=512
lr_scheduler_type="polynomial"
max_eval_samples=1600
logging_steps=10
save_strategy="epochs"
eval_strategy="steps" #"epochs"
save_steps=100 #5000
eval_steps=100
if [ "${debug}" = 1 ];
then
    weight_decay=0
    max_grad_norm=1
    max_train_samples=1000
    max_eval_samples=150
    bsz=32 #10
    gradient_steps=1
    num_train_epochs=5
    max_steps=-1
    eval_strategy='steps'
    save_steps=100
    report_to="none"
    logging_steps=10
    extra_cmd="--max_train_samples ${max_train_samples} --max_predict_samples 150"
    debug_str=".debug"
fi
rm checkpoints/hf_model/downloads/*.lock
rm checkpoints/hf_model/*.lock
real_bsz=`expr ${bsz} \* ${gradient_steps} \* ${nodes_num}`
exp_name=ia3_train.${lr}.${max_steps}.${real_bsz}.${weight_decay}.${SLURM_ARRAY_JOB_ID}.${SLURM_ARRAY_TASK_ID}
SAVE=checkpoints/glue/${TASK_NAME}/${DATE}/${exp_name}
python -m torch.distributed.launch --nproc_per_node=2 examples/pytorch/summarization/prompt_run_glue.py \
  --model_name_or_path "t5-base" \
  --train_file split-train-set/rte-train.json \
  --validation_file split-train-set/rte-eval.json \
  --dataset_config_name ${TASK_NAME} \
  --text_column "sentence" \
  --summary_column "label" \
  --do_train \
  --train_adapter \
  --predict_with_generate True \
  --per_device_train_batch_size ${bsz} \
  --per_device_eval_batch_size ${bsz} \
  --adam_beta1 0.9 \
  --adam_beta2 0.98 \
  --adam_epsilon 1e-6 \
  --gradient_accumulation_steps ${gradient_steps} \
  --max_steps ${max_steps} \
  --num_train_epochs ${num_train_epochs} \
  --learning_rate ${lr} \
  --lr_scheduler_type ${lr_scheduler_type} \
  --max_grad_norm ${max_grad_norm} \
  --weight_decay ${weight_decay} \
  --warmup_steps ${warmup_updates} \
  --warmup_ratio ${warmup_ratio} \
  --logging_steps ${logging_steps} \
  --save_total_limit 5 \
  --evaluation_strategy ${eval_strategy} \
  --save_strategy ${eval_strategy} \
  --save_steps ${save_steps} \
  --eval_steps ${save_steps} \
  --load_best_model_at_end \
  --report_to ${report_to} \
  --run_name ${TASK_NAME}.${DATE}.${exp_name} \
  --overwrite_output_dir \
  --metric_for_best_model ${metric} \
  --greater_is_better "True" \
  --adapter_config ${adapter_config} \
  --disable_tqdm "True" \
  --output_dir ${SAVE} \
    2>&1 | tee ${SAVE}/log.txt
