#!/bin/bash
#FLUX: --job-name=cont5submem
#FLUX: -c=4
#FLUX: -t=1296000
#FLUX: --urgency=16

CURRENT="$PWD"
DUMPED_PATH="$CURRENT/dumped"
EXP_FOLDER=$DUMPED_PATH/"continual/finetune_subspace_memory_base+novel_converge"
DATA_PATH="$CURRENT/data"
mkdir -p $EXP_FOLDER
cnt=0
for TRLOSS in 0.0; do
for LR in 0.002; do
for LMBD in 0.2; do
for LMBDN in 0.1; do
for PULL in 1.0; do
for SEED in {1..10}; do
(( cnt++ ))
if [[ $cnt -eq $SLURM_ARRAY_TASK_ID ]]; then
    EXP_NAME=seed_${SEED}_trloss_${TRLOSS}_lmbd_${LMBD}_lmbdN_${LMBDN}_pull_${PULL}_${SLURM_ARRAY_TASK_ID}
    LOG_STDOUT="${EXP_FOLDER}/${EXP_NAME}.out"
    LOG_STDERR="${EXP_FOLDER}/${EXP_NAME}.err"
    BACKBONE_PATH="${DUMPED_PATH}/backbones/continual/resnet18/${SEED}/resnet18_last.pth"
    python eval_incremental.py --model_path $BACKBONE_PATH \
                           --model resnet18 \
                           --no_dropblock \
                           --data_root $DATA_PATH \
                           --n_shots 5 \
                           --classifier linear \
                           --eval_mode few-shot-incremental-fine-tune \
                           --min_novel_epochs 20 \
                           --learning_rate $LR \
                           --freeze_backbone_at 1 \
                           --test_base_batch_size 2000 \
                           --continual \
                           --num_workers 0 \
                           --n_queries 25 \
                           --lmbd_reg_transform_w $LMBD \
                           --target_train_loss $TRLOSS \
                           --label_pull $PULL \
                           --lmbd_reg_novel $LMBDN \
                           --set_seed $SEED \
                           --attraction_override "distance2subspace" \
                           --n_base_support_samples 1 \
                           --memory_replay 1 > $LOG_STDOUT 2> $LOG_STDERR
fi
done
done
done
done
done
done
