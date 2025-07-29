#!/bin/bash
#SBATCH --account=Project_2002026
#SBATCH --output=logs/%j.out
#SBATCH --error=logs/%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --gres=gpu:v100:1
#SBATCH --mem=64G
#SBATCH --time=01:30:00
#SBATCH --constraint=ntasks-per-node=1

export OUTPUT_DIR='models'
export PRED_DIR='predictions'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow/2.2
MODEL="jplu/tf-xlm-roberta-base"
EPOCHS=0
BS=128
PRED=$1
export OUTPUT_DIR=models
export PRED_DIR=predictions
mkdir -p "$OUTPUT_DIR"
mkdir -p "$PRED_DIR"
srun python train_lstm.py \
  --model_name $MODEL \
  --pred $PRED \
  --input_format json \
  --seq_len 512 \
  --max_lines 50 \
  --epochs $EPOCHS \
  --batch_size $BS \
  --load_model $2 \
  --lstm_model $3 \
  --threshold 0.5 \
  --save_predictions $PRED_DIR/$PRED.classified \
echo "job=$SLURM_JOBID src=$SRC trg=$TRG model=$MODEL lr=$LR epochs=$EPOCHS batch_size=$BS" >> logs/completed.log
echo "END: $(date)"
