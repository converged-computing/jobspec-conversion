#!/bin/bash
#FLUX: --job-name=confused-banana-9028
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MODEL_DIR='/scratch/project_2002026/bert/cased_L-24_H-1024_A-16'
export SOURCE_DIR='/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel'
export DATA_DIR='data'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MODEL_DIR=/scratch/project_2002026/bert/cased_L-24_H-1024_A-16
export SOURCE_DIR=/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel
export DATA_DIR=data
export OUTPUT_DIR=output
mkdir -p "$OUTPUT_DIR"
LR=7e-6
EPOCHS=4  #3-5
BS=7 #7
COMMENT="bert-large,cls,amsgrad,warmup0.1,devBeg"
DATA_SUFFIX=""
echo -e "$SLURM_JOBID\t$LR\t$EPOCHS\t$BS\t$DATA_SUFFIX\t$COMMENT" >> experiments.log
for f in 1 2 3;
do srun python bert_fine_tune_multigpu.py \
  --train $DATA_DIR/train$DATA_SUFFIX-processed.jsonl.gz \
  --dev $DATA_DIR/dev-processed.jsonl.gz \
  --init_checkpoint $MODEL_DIR/bert_model.ckpt \
  --bert_config $MODEL_DIR/bert_config.json \
  --lr $LR \
  --seq_len 512 \
  --epochs $EPOCHS \
  --batch_size $BS \
  --output_file $OUTPUT_DIR/model$DATA_SUFFIX-$SLURM_JOBID-$f.h5
done;
echo "END: $(date)"
