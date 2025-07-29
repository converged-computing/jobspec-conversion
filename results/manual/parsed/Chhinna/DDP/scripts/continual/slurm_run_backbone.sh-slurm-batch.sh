#!/bin/bash
#SBATCH --job-name=resnet18
#SBATCH --output=dumped/%A_%a.out
#SBATCH --error=dumped/%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --gres=gpu:volta:1
#SBATCH --time=15-00:00:00
#SBATCH --constraint=xeon-g6,ntasks-per-node=1
#SBATCH --array=1-10

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
