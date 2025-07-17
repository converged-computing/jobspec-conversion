#!/bin/bash
#FLUX: --job-name=dinosaur-fork-1659
#FLUX: --queue=gpu
#FLUX: -t=4500
#FLUX: --urgency=16

export PYTHONPATH='/scratch/project_2002026/samuel/transformer-text-classifier/transformers3.4/lib/python3.7/site-packages:$PYTHONPATH'
export BG_FILES='data/eacl/en/train.tsv data/eacl/fi/train.tsv data/eacl/sv/train.tsv'
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
SRC=fr
TRG=$1
BG="en fi sv"
export BG_FILES="data/eacl/en/train.tsv data/eacl/fi/train.tsv data/eacl/sv/train.tsv"
export TRAIN_DIR=data/eacl/$SRC
export DEV_DIR=data/eacl/$TRG
export OUTPUT_DIR=output
mkdir -p "$OUTPUT_DIR"
MODEL_ALIAS="xlmR"
MODEL="jplu/tf-xlm-roberta-large"
BS=7
BGrate=1.0
echo "Settings: src=$SRC trg=$TRG bg=$BG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS"
srun python train.py \
  --model_name $MODEL \
  --load_weights "$2" \
  --train $TRAIN_DIR/train.tsv \
  --dev $DEV_DIR/dev.tsv \
  --test $DEV_DIR/test.tsv \
  --bg_train "$BG_FILES" \
  --bg_sample_rate $BGrate \
  --input_format tsv \
  --threshold 0.5 \
  --seq_len 512 \
  --batch_size $BS \
  --epochs 0 \
  --test_log_file "$3"
echo "END: $(date)"
