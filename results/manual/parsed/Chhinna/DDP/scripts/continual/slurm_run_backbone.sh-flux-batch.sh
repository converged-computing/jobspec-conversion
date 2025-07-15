#!/bin/bash
#FLUX: --job-name=resnet18
#FLUX: -c=8
#FLUX: -t=1296000
#FLUX: --urgency=16

CURRENT="$PWD"
DUMPED_PATH="$CURRENT/dumped"
DATA_PATH="$CURRENT/data"
BACKBONE_FOLDER=${DUMPED_PATH}/backbones/continual/resnet18
 #   EXP_FOLDER=$BACKBONE_FOLDER/$SEED
  #  mkdir -p $EXP_FOLDER
 #   LOG_STDERR="${EXP_FOLDER}/${EXP_NAME}.err"
  #  python train_supervised.py --trial pretrain \
   #                            --tb_path tb \
    #                           --data_root $DATA_PATH \
 #                              --model_path $EXP_FOLDER \
  #                             --continual \
   #                            --model resnet18 \
    #                           --no_dropblock \
     #                          --save_freq 100 \
      #                         --no_linear_bias \
       #                        --set_seed $SEED > $LOG_STDOUT 2> $LOG_STDERR
 /nfs4/anurag/ddpac/bin/python train_supervised.py --trial pretrain \
                                --tb_path tb \
                                --data_root $DATA_PATH \
                                --classifier linear \
                                --model_path $BACKBONE_FOLDER/1 \
                                --continual \
                                --model resnet18 \
                                --no_dropblock \
                                --save_freq 100 \
                                --no_linear_bias \
                                --set_seed 1
