#!/bin/bash
#FLUX: --job-name=red-general-2527
#FLUX: --priority=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MODEL_DIR='/scratch/project_2002026/bert/cased_L-12_H-768_A-12'
export SOURCE_DIR='/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel'
export DATA_DIR='data/train-10-fold-prep'
export OUTPUT_DIR='output'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
DATA_SUFFIX="_fulldoc"
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MODEL_DIR=/scratch/project_2002026/bert/cased_L-12_H-768_A-12
export SOURCE_DIR=/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel
export DATA_DIR=data/train-10-fold-prep
export OUTPUT_DIR=output
mkdir -p "$OUTPUT_DIR"
srun python3 $SOURCE_DIR/bert_predict.py --test data/dev-processed.jsonl.gz --model $OUTPUT_DIR/model$DATA_SUFFIX.h5 --labels data/labels.json --output_file $OUTPUT_DIR/pred_fulldoc-train_beg-dev.txt --clip_value 1e-4 --seq_len 512 --eval_batch_size 6
for f in {8,9,10}; do
  DATA_SUFFIX="fulldoc-fold-$f"
  #srun python3 $SOURCE_DIR/bert_predict.py --test $DATA_DIR/$DATA_SUFFIX-test-processed.jsonl.gz --model $OUTPUT_DIR/model_$DATA_SUFFIX.h5 --labels data/labels.json --output_file $OUTPUT_DIR/pred_$DATA_SUFFIX.txt --clip_value 1e-4 --seq_len 512 --eval_batch_size 6
done
echo "END: $(date)"
