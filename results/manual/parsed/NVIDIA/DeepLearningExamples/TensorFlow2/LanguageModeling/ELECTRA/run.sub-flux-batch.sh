#!/bin/bash
#FLUX: --job-name=conspicuous-soup-2338
#FLUX: --exclusive
#FLUX: --priority=16

set -eux
readonly docker_image="gitlab-master.nvidia.com/dl/joc/electra_tf2:keras_mp_20.07_clean_up"
readonly datadir="/lustre/fsw/joc-luna/sharatht/electra_tf2_data/"
readonly mounts=".:/workspace/electra,${datadir}:/workspace/electra/data"
DGXSYSTEM=DGXA100
cluster="selene"
if [[ "${DGXSYSTEM}" == DGX2* ]]; then
    cluster='circe'
fi
if [[ "${DGXSYSTEM}" == DGXA100* ]]; then
    cluster='selene'
fi
BIND_CMD="./scripts/bind.sh --cpu=exclusive --ib=single --cluster=$cluster -- "
BATCHSIZE=${BATCHSIZE:-16}
PHASE=${PHASE:-1}
LR=${LR:-3e-3}
STEPS=${STEPS:-57450}
WARMUP=${WARMUP:-3750}
GRAD_ACCUM_STEPS=${GRAD_ACCUM_STEPS:-1}
b1=${b1:-"0.878"}
b2=${b2:-"0.974"}
decay=${decay:-"0.5"}
end_lr=${end_lr:-"0.0"}
skip_adaptive=${skip_adaptive:-"yes"}
model_count=${model_count:-1}
skip_flag=""
if [ "$skip_adaptive" = "yes" ] ; then
    skip_flag=" --skip_adaptive"
fi
ckpt_STEPS=$(awk -v a=$STEPS 'BEGIN { print a / 10}')
if [ "$PHASE" = "1" ] ; then
LAUNCH_CMD="$BIND_CMD python run_pretraining.py \
    --model_name='electra_keras_mp_base_lamb_48x8x${BATCHSIZE}x${GRAD_ACCUM_STEPS}_p1_skip_adaptive_${skip_adaptive}_LR_${LR}_WARMUP_${WARMUP}_STEPS_${STEPS}_b1_${b1}_b2_${b2}_decay_${decay}_end_lr_${end_lr}_${model_count}' \
    --pretrain_tfrecords='/workspace/electra/data/tfrecord_lower_case_1_seq_len_128_random_seed_12345/books_wiki_en_corpus/train/pretrain_data*' \
    --num_train_steps=$STEPS \
    --num_warmup_steps=$WARMUP \
    --disc_weight=50.0 \
    --generator_hidden_size=0.3333333 \
    --learning_rate=$LR \
    --train_batch_size=$BATCHSIZE \
    --max_seq_length=128 --log_freq=10 \
    --save_checkpoints_steps=$ckpt_STEPS \
    --optimizer='lamb' $skip_flag --opt_beta_1=$b1 --opt_beta_2=$b2 --lr_decay_power=$decay --end_lr=$end_lr $skip_flag --gradient_accumulation_steps=$GRAD_ACCUM_STEPS --amp --xla "
else
LAUNCH_CMD="$BIND_CMD python run_pretraining.py \
    --model_name='electra_keras_mp_base_lamb_48x8x176x1_p1_skip_adaptive_yes_LR_6e-3_WARMUP_2000_STEPS_10000_b1_0.878_b2_0.974_decay_0.5_end_lr_0.0_${model_count}' \
    --pretrain_tfrecords='/workspace/electra/data/tfrecord_lower_case_1_seq_len_512_random_seed_12345/books_wiki_en_corpus/train/pretrain_data*' \
    --num_train_steps=$STEPS \
    --num_warmup_steps=$WARMUP \
    --disc_weight=50.0 \
    --generator_hidden_size=0.3333333 \
    --learning_rate=$LR \
    --train_batch_size=$BATCHSIZE \
    --max_seq_length=512 --log_freq=10 \
    --restore_checkpoint --phase2 \
    --save_checkpoints_steps=$ckpt_STEPS \
    --optimizer='lamb' $skip_flag --opt_beta_1=$b1 --opt_beta_2=$b2 --lr_decay_power=$decay --end_lr=$end_lr $skip_flag --gradient_accumulation_steps=$GRAD_ACCUM_STEPS --amp --xla "
fi;
srun --mpi=pmi2 -l --container-image="${docker_image}" --container-mounts="${mounts}" bash -c "${LAUNCH_CMD}"
