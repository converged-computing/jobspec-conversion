#!/bin/bash
#FLUX: --job-name=blank-latke-5784
#FLUX: --queue=gpu
#FLUX: -t=58500
#FLUX: --urgency=16

export PYTHONPATH='/scratch/project_2002026/samuel/transformer-text-classifier/transformers3.4/lib/python3.7/site-packages:$PYTHONPATH'
export TRAIN_DIR='data/eacl/$SRC'
export DEV_DIR='data/eacl/$TRG'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow/2.2-hvd
source transformers3.4/bin/activate
export PYTHONPATH=/scratch/project_2002026/samuel/transformer-text-classifier/transformers3.4/lib/python3.7/site-packages:$PYTHONPATH
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
export TRAIN_DIR=data/eacl/$SRC
export DEV_DIR=data/eacl/$TRG
export OUTPUT_DIR=output
mkdir -p "$OUTPUT_DIR"
for EPOCHS in $EPOCHS_; do
for LR in $LR_; do
for j in $i; do
echo "Settings: src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS"
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/experiments.log
srun python train.py \
  --model_name $MODEL \
  --train $TRAIN_DIR/train.tsv \
  --dev $DEV_DIR/dev.tsv \
  --test $DEV_DIR/test.tsv \
  --input_format tsv \
  --lr $LR \
  --seq_len 512 \
  --epochs $EPOCHS \
  --batch_size $BS \
  --output_file $OUTPUT_DIR/$MODEL_ALIAS-$SRC-$TRG-lr$LR-ep$EPOCHS-$j.h5 \
  --log_file logs/train_$MODEL_ALIAS-$SRC-$TRG.tsv \
  --test_log_file logs/test_$MODEL_ALIAS-$SRC-$TRG.tsv
done
done
done
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/completed.log
echo "END: $(date)"
