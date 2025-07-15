#!/bin/bash
#FLUX: --job-name=ofa_okvqa_vqa
#FLUX: --queue=gengpu
#FLUX: -t=172800
#FLUX: --urgency=16

export MASTER_ADDR='localhost'
export MASTER_PORT='8214'
export RANK='0'

source /opt/flight/etc/setup.sh
flight env activate gridware
module purge
module load libs/nvidia-cuda/11.2.0/bin
module load /users/adbm760/anaconda3
source /users/adbm760/anaconda3/etc/profile.d/conda.sh
conda activate ofa
nvidia-smi
GPUS_PER_NODE=1
WORKER_CNT=1
export MASTER_ADDR=localhost
export MASTER_PORT=8214
export RANK=0
data_dir=okvqa/dataset
data=${data_dir}/okvqa_train_val.tsv,${data_dir}/okvqa_val.tsv
ans2label_file=${data_dir}/trainval_ans2label.p
starting_model=vqa_base_best
restore_file=checkpoints/${starting_model}.pt
selected_cols=0,5,2,3,4
log_dir=okvqa_logs
save_dir=../../archive/okvqa_checkpoints
mkdir -p $log_dir $save_dir
bpe_dir=utils/BPE
user_dir=ofa_module
task=okvqa_gen
arch=ofa_base
criterion=adjust_label_smoothed_cross_entropy
label_smoothing=0.1
batch_size=16
update_freq=4
resnet_drop_path_rate=0.0
encoder_drop_path_rate=0.2
decoder_drop_path_rate=0.2
dropout=0.1
attention_dropout=0.0
max_src_length=80
max_object_length=30
max_tgt_length=30
num_bins=1000
patch_image_size=480
uses_ema="--uses-ema"
store_ema="--store-ema"
ema_fp32="--ema-fp32"
ema_decay=0.9999
ema_start_update=0
for max_epoch in {200,}; do
  echo "max_epoch "${max_epoch}
  for warmup_ratio in {0.04,}; do
    echo "warmup_updates "${warmup_updates}
    for lr in {5e-5,}; do
      echo "lr "${lr}
      for patch_image_size in {480,}; do
        echo "patch_image_size "${patch_image_size}
        log_file=${log_dir}/${max_epoch}"_"${warmup_ratio}"_"${lr}"_"${patch_image_size}"_rank"${RANK}".log"
        save_path=${save_dir}/${max_epoch}"_"${warmup_ratio}"_"${lr}"_"${patch_image_size}"_"${starting_model}
        mkdir -p $save_path
        CUDA_VISIBLE_DEVICES=4,5,6,7 python train_ok.py \
            ${data} \
            --selected-cols=${selected_cols} \
            --bpe-dir=${bpe_dir} \
            --user-dir=${user_dir} \
            --restore-file=${restore_file} \
            --reset-optimizer --reset-dataloader --reset-meters \
            --save-dir=${save_path} \
            --task=${task} \
            --arch=${arch} \
            --disable-validation \
            --criterion=${criterion} \
            --label-smoothing=${label_smoothing} \
            --batch-size=${batch_size} \
            --update-freq=${update_freq} \
            --encoder-normalize-before \
            --decoder-normalize-before \
            --share-decoder-input-output-embed \
            --share-all-embeddings \
            --layernorm-embedding \
            --patch-layernorm-embedding \
            --code-layernorm-embedding \
            --resnet-drop-path-rate=${resnet_drop_path_rate} \
            --encoder-drop-path-rate=${encoder_drop_path_rate} \
            --decoder-drop-path-rate=${decoder_drop_path_rate} \
            --dropout=${dropout} \
            --attention-dropout=${attention_dropout} \
            --weight-decay=0.01 \
            --optimizer=adam \
            --adam-betas="(0.9,0.999)" \
            --adam-eps=1e-08 \
            --clip-norm=1.0 \
            --lr-scheduler=polynomial_decay \
            --lr=${lr} \
            --max-epoch=${max_epoch} \
            --warmup-ratio=${warmup_ratio} \
            --log-format=simple \
            --log-interval=10 \
            --fixed-validation-seed=7 \
            --keep-last-epochs=15 \
            --save-interval=50 --validate-interval=100 \
            --best-checkpoint-metric=vqa_score --maximize-best-checkpoint-metric \
            --max-src-length=${max_src_length} \
            --max-object-length=${max_object_length} \
            --max-tgt-length=${max_tgt_length} \
            --find-unused-parameters \
            --freeze-encoder-embedding \
            --freeze-decoder-embedding \
            --ans2label-file=${ans2label_file} \
            --valid-batch-size=20 \
            --add-type-embedding \
            --scale-attn \
            --scale-fc \
            --scale-heads \
            --disable-entangle \
            --num-bins=${num_bins} \
            --patch-image-size=${patch_image_size} \
            --prompt-type=prev_output \
            --fp16 \
            --fp16-scale-window=512 \
            --add-object \
            ${uses_ema} \
            ${store_ema} \
            ${ema_fp32} \
            --ema-decay=${ema_decay} \
            --ema-start-update=${ema_start_update} \
            --num-workers=0
      done
    done
  done
done
