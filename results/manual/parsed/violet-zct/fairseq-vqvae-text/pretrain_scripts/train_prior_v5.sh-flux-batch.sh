#!/bin/bash
#FLUX: --job-name=argmax.transformer.lm.pretrain.lm
#FLUX: -N=2
#FLUX: -c=10
#FLUX: --queue=priority
#FLUX: -t=259200
#FLUX: --priority=16

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
module load cuda/10.0
source activate py36
DATE=`date +%Y%m%d`
model_name='soft_lm_65536_4'
vqvae_model_root=/checkpoint/chuntinz/work/fairseq/saved_models
vqvae_model=vqvae_65536_pretrain_lm_fix_c33_mintemp_5
vqvae_model_path=${vqvae_model_root}/${vqvae_model}/checkpoint_last.pt
SAVE_ROOT=/checkpoint/chuntinz/work/fairseq/saved_models
DATA='/checkpoint/chuntinz/work/data/data-bin/doc-ende19-v2'
model=transformer_lm
PORT=15213
SAVE=${SAVE_ROOT}/lm_prior_argmax_fix_pretrain_lm_${model_name}
mkdir -p ${SAVE}
cp $0 ${SAVE}/train_prior.sh
srun --label python -u train.py ${DATA}\
    --arch ${model} --distributed-port $PORT --distributed-world-size 16 \
    --task soft_language_modeling \
    --criterion soft_cross_entropy --label-smoothing 0.0 \
    --context-model-path ${vqvae_model_path} --code-extract-strategy argmax \
    --save-dir $SAVE --share-decoder-input-output-embed \
    --seed 1 --decoder-normalize-before \
    --max-update 70000000 \
    --warmup-updates 6000 --warmup-init-lr 1e-07 \
    --optimizer adam --lr 0.0003 --min-lr '1e-09' --lr-scheduler inverse_sqrt --weight-decay 0.0001 --adam-betas '(0.9, 0.98)' \
    --skip-invalid-size-inputs-valid-test --ddp-backend=no_c10d \
    --keep-last-epochs 5 --max-tokens 6084 --num-workers 0 \
    --dataset-impl mmap \
    --log-format simple --log-interval 500 | tee ${SAVE}/log.txt
