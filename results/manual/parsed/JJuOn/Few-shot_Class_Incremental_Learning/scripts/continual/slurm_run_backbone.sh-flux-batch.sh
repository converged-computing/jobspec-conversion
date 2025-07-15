#!/bin/bash
#FLUX: --job-name=resnet18
#FLUX: -c=8
#FLUX: -t=1296000
#FLUX: --priority=16

CURRENT="$PWD"
DUMPED_PATH="$CURRENT/dumped"
DATA_PATH="$CURRENT/data"
BACKBONE_FOLDER=${DUMPED_PATH}/backbones/continual/resnet18
mkdir -p $BACKBONE_FOLDER
:<<'cmt'
cnt=0
for SEED in {1..10}; do
(( cnt++ ))
if [[ $cnt -eq $SLURM_ARRAY_TASK_ID ]]; then 
    EXP_NAME=continual_backbone_seed_${SEED}
    EXP_FOLDER=$BACKBONE_FOLDER/$SEED
    mkdir -p $EXP_FOLDER
    LOG_STDOUT="${EXP_FOLDER}/${EXP_NAME}.out"
    LOG_STDERR="${EXP_FOLDER}/${EXP_NAME}.err"
    python train_supervised.py --trial pretrain \
                               --tb_path tb \
                               --data_root $DATA_PATH \
                               --classifier linear \
                               --model_path $EXP_FOLDER \
                               --continual \
                               --model resnet18 \
                               --no_dropblock \
                               --save_freq 100 \
                               --no_linear_bias \
                               --set_seed $SEED > $LOG_STDOUT 2> $LOG_STDERR
fi
done
cmt
python train_supervised.py --trial pretrain \
                               --tb_path tb \
                               --data_root $DATA_PATH \
                               --classifier linear \
                               --model_path $BACKBONE_FOLDER/2/base20 \
                               --continual \
                               --model resnet18 \
                               --no_dropblock \
                               --save_freq 100 \
                               --no_linear_bias \
                               --set_seed 2 | tee logs/run_backbone_seed2_base20.out
