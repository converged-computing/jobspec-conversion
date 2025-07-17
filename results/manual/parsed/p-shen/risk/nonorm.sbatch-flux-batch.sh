#!/bin/bash
#FLUX: --job-name=nonorm
#FLUX: -n=8
#FLUX: --queue=short
#FLUX: -t=240
#FLUX: --urgency=16

source /home/pzs2/keras/bin/activate
today=`date '+%m_%d__%H_%M'`;
JOB_DIR="/home/pzs2/capstone/models/no_norm_$today"
DATA_DIR="/home/pzs2/capstone/proj/TCGA_processed/pancancer_all_immune_non_norm_surv"
TRAIN_STEPS=80
BATCH_SIZE=128
LEARNING_RATE=0.0003
TRAIN_FILE="$DATA_DIR/TrainingData.txt"
EVAL_FILE="$DATA_DIR/EvalData.txt"
VALIDATION_FILE="$DATA_DIR/TestData.txt"
TRAIN_LABEL="$DATA_DIR/surv.train.txt"
EVAL_LABEL="$DATA_DIR/surv.eval.txt"
VALIDATION_LABEL="$DATA_DIR/surv.test.txt"
LOSS_FN="negative_log_partial_likelihood"
ACT_FN="linear"
CLASS_SIZE=1
MODEL1_FILE_NAME="surv.hdf5"
python -m trainer.task --train-files $TRAIN_FILE $TRAIN_LABEL \
                       --validation-files $VALIDATION_FILE $VALIDATION_LABEL \
                       --eval-files $EVAL_FILE $EVAL_LABEL \
                       --loss-fn $LOSS_FN \
                       --activation-fn $ACT_FN \
                       --class-size $CLASS_SIZE \
                       --job-dir $JOB_DIR \
                       --model-file-name $MODEL1_FILE_NAME \
                       --train-steps $TRAIN_STEPS \
                       --learning-rate $LEARNING_RATE \
                       --num-epochs 500 \
                       --early-stop 100 \
                       --train-batch-size $BATCH_SIZE \
                       --eval-frequency 10 \
                       --checkpoint-epochs 5
