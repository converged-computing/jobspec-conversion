#!/bin/bash
#FLUX: --job-name=milky-truffle-4095
#FLUX: --queue=gpu
#FLUX: -t=4500
#FLUX: --urgency=16

export TRAIN_DIR='junkdata/$SRC'
export DEV_DIR='junkdata/$TRG'
export OUTPUT_DIR='models'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow/2.2
MODEL=$1
MODEL_ALIAS=$2
SRC=$3
TRG=$4
LR_=$5
EPOCHS_=$6
i=$7
BS=128
echo "MODEL:$MODEL"
echo "MODEL_ALIAS:$MODEL_ALIAS"
echo "SRC:$SRC"
echo "TRG:$TRG"
echo "LR:$LR_"
echo "EPOCHS:$EPOCHS_"
echo "i:$i"
export TRAIN_DIR=junkdata/$SRC
export DEV_DIR=junkdata/$TRG
export OUTPUT_DIR=models
mkdir -p "$OUTPUT_DIR"
for EPOCHS in $EPOCHS_; do
for LR in $LR_; do
for j in $i; do
echo "Settings: src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS"
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/experiments.log
srun python train_lstm.py \
  --model_name $MODEL \
  --train $TRAIN_DIR/train.json \
  --dev $DEV_DIR/dev.json \
  --test $DEV_DIR/test.json \
  --input_format json \
  --lr $LR \
  --seq_len 512 \
  --epochs $EPOCHS \
  --batch_size $BS \
  --threshold 0.5 \
  --max_lines 50 \
  --log_file logs/train_$MODEL_ALIAS-$SRC-$TRG.tsv \
  --test_log_file logs/test_$MODEL_ALIAS-$SRC-$TRG.tsv \
  --load_model $OUTPUT_DIR/xmlr-de-en-es-fi-fr-se-de-en-es-fi-fr-se-lr2e-6-ep6-1.h5 \
done
done
done
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/completed.log
echo "END: $(date)"
