#!/bin/bash
#FLUX: --job-name=peachy-toaster-9331
#FLUX: --queue=gpu
#FLUX: -t=33300
#FLUX: --urgency=16

export TRAIN_DIR='junkdata/$SRC'
export DEV_DIR='junkdata/$TRG'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow/2.4
MODEL=$1
MODEL_ALIAS=$2
SRC=$3
TRG=$4
LR_=$5
EPOCHS_=$6
i=$7
BS=7
echo "MODEL:$MODEL"
echo "MODEL_ALIAS:$MODEL_ALIAS"
echo "SRC:$SRC"
echo "TRG:$TRG"
echo "LR:$LR_"
echo "EPOCHS:$EPOCHS_"
echo "i:$i"
export TRAIN_DIR=junkdata/$SRC
export DEV_DIR=junkdata/$TRG
export OUTPUT_DIR=output
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
done
done
done
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/completed.log
echo "END: $(date)"
