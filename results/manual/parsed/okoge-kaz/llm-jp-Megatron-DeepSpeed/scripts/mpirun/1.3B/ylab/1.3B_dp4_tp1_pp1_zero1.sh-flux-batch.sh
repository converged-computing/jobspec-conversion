#!/bin/bash
#FLUX: --job-name=gpt
#FLUX: -t=86400
#FLUX: --urgency=16

. /etc/profile.d/modules.sh
module load cuda/11.7
module load cudnn/cuda-11.x/8.9.0
module load nccl/cuda-11.7/2.14.3
module load openmpi/4.0.5
MASTER_NODE=$(/usr/sbin/ip a show | grep inet | grep 192.168.205 | head -1 | cut -d " " -f 6 | cut -d "/" -f 1)
MASTER_PORT=$((10000 + ($SLURM_JOBID % 50000)))
model_size=1.3
num_layers=24
hidden_size=2048
num_attn_heads=16
sequence_length=2048
global_batch_size=512
lr=2.0e-4
min_lr=1.0e-6
init_std=0.013
train_tokens_in_billion=300
train_tokens=$((${train_tokens_in_billion} * 1000 * 1000 * 1000))
train_samples=$((300 * 1000000000 * 2 / ${sequence_length}))
exit_duration=30000000
lr_warmup_tokens_in_million=3000
lr_warmup_tokens=$((${lr_warmup_tokens_in_million} * 1000000))
lr_decay_tokens_in_billion=${train_tokens_in_billion}
lr_decay_tokens=$((${lr_decay_tokens_in_billion} * 1000000000))
lr_decay_style="cosine"
mp_size=1 # tensor model parallel size
pp_size=1
no_pp="false"
zero_stage=1
num_gpus_pernode=4
num_node=1
num_gpus=$((${num_gpus_pernode} * ${num_node}))
dp_size=$((${num_gpus} / ${pp_size} / ${mp_size}))
batch_size=1
log_interval=1
eval_iters=10
eval_interval=100
num_save=100
estimated_train_iter=$((${train_tokens} / ${sequence_length} / ${global_batch_size}))
save_interval=100
activation_checkpoint="false"
log_optimizer_state="true"
current_time=$(date "+%Y.%m.%d_%H.%M.%S")
host="${HOSTNAME}"
seed=1234
num_workers=0
data_path="dataset/BookCorpusDataset_text_document"
vocab_path="dataset/gpt2-vocab.json"
merge_path="dataset/gpt2-merges.txt"
prescale_grad="true"
jobname="gpt_${model_size}B_tok${train_tokens_in_billion}B"
jobname="${jobname}_lr${lr}_min${min_lr}_w${lr_warmup_tokens_in_million}M_d${lr_decay_tokens_in_billion}B_${lr_decay_style}"
jobname="${jobname}_gbs${global_batch_size}_mbs${batch_size}_g${num_gpus}"
if [[ $zero_stage -gt 0 ]]; then
  jobname="${jobname}_z${zero_stage}"
  prescale_grad="false"
fi
if [[ $mp_size -gt 1 ]]; then
  jobname="${jobname}_mp${mp_size}"
fi
if [ "${no_pp}" = "false" ]; then
  jobname="${jobname}_pp${pp_size}"
fi
jobname="${jobname}_seed${seed}_rebase"
output_home="outputs"
log_path="${output_home}/log/"
checkpoint_path="${output_home}/checkpoint/${jobname}"
tensorboard_dir="${output_home}/tensorboard/"
tensorboard_path="${tensorboard_dir}${jobname}_${host}_${current_time}"
mkdir -p ${log_path}
mkdir -p ${checkpoint_path}
mkdir -p ${tensorboard_path}
data_options=" \
    --vocab-file ${vocab_path} \
    --merge-file ${merge_path} \
    --data-path ${data_path} \
    --data-impl mmap"
megatron_options=" \
    --override-opt_param-scheduler \
    --adam-beta1 0.9 \
    --adam-beta2 0.95 \
    --tensor-model-parallel-size ${mp_size} \
    --init-method-std ${init_std} \
    --lr-decay-tokens ${lr_decay_tokens} \
    --lr-warmup-tokens ${lr_warmup_tokens} \
    --micro-batch-size ${batch_size} \
    --exit-duration-in-mins ${exit_duration} \
    --global-batch-size ${global_batch_size} \
    --num-layers ${num_layers} \
    --hidden-size ${hidden_size} \
    --num-attention-heads ${num_attn_heads} \
    --seq-length ${sequence_length} \
    --max-position-embeddings ${sequence_length} \
    --train-tokens ${train_tokens} \
    --train-samples ${train_samples} \
    --lr ${lr} \
    --min-lr ${min_lr} \
    --lr-decay-style ${lr_decay_style} \
    --split 949,50,1 \
    --log-interval ${log_interval} \
    --eval-interval ${eval_interval} \
    --eval-iters ${eval_iters} \
    --save-interval ${save_interval} \
    --weight-decay 0.1 \
    --clip-grad 1.0 \
    --hysteresis 2 \
    --num-workers ${num_workers} \
    --distributed-backend nccl \
    --use-flash-attn \
    --fp16 \
    --seed ${seed} \
    --load ${checkpoint_path} \
    --save ${checkpoint_path} \
    --no-async-tensor-model-parallel-allreduce \
    --tensorboard-queue-size 1 \
    --log-timers-to-tensorboard \
    --log-batch-size-to-tensorboard \
    --log-validation-ppl-to-tensorboard \
    --tensorboard-dir ${tensorboard_path}"
if [ "${activation_checkpoint}" = "true" ]; then
  megatron_options="${megatron_options} \
    --checkpoint-activations"
fi
if [ "${log_optimizer_state}" = "true" ]; then
  megatron_options="${megatron_options} \
    --log-optimizer-states-to-tensorboard"
fi
config_json="scripts/deepspeed/config/ds_config_gbs${global_batch_size}_mbs${batch_size}_log${log_interval}_zero${zero_stage}.json"
template_json="examples_deepspeed/rebase/ds_config_gpt_TEMPLATE.json"
sed "s/GBSIZE/${global_batch_size}/" ${template_json} |
  sed "s/MBSIZE/${batch_size}/" |
  sed "s/LOG_INTERVAL/${log_interval}/" |
  sed "s/ZERO_STAGE/${zero_stage}/" |
  sed "s/PRESCALE_GRAD/${prescale_grad}/" \
    >${config_json}
deepspeed_options=" \
    --deepspeed \
    --deepspeed_config ${config_json} \
    --zero-stage ${zero_stage} \
    --pipeline-model-parallel-size ${pp_size}"
if [[ "${no_pp}" = "true" ]]; then
  deepspeed_options="${deepspeed_options} \
    --no-pipeline-parallel"
fi
if [ "${activation_checkpoint}" = "true" ]; then
  deepspeed_options="${deepspeed_options} \
    --deepspeed-activation-checkpointing"
fi
source .env/bin/activate
mpirun -np $num_gpus \
  --npernode $num_gpus_pernode \
  -x MASTER_ADDR=$MASTER_NODE \
  -x MASTER_PORT=$MASTER_PORT \
  -bind-to none -map-by slot \
  -x NCCL_DEBUG=INFO  -x PATH \
  -x LD_LIBRARY_PATH \
  python pretrain_gpt.py \
  ${megatron_options} \
  --use-mpi \
  ${data_options} \
  ${deepspeed_options}
