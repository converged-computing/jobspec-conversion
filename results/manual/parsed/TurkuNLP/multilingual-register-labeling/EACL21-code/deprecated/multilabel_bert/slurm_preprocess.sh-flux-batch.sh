#!/bin/bash
#FLUX: --job-name=doopy-toaster-9081
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MODEL_DIR='/scratch/project_2002026/bert/cased_L-12_H-768_A-12'
export DATA_DIR='/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/CORE-final'
export OUTPUT_DIR='data'
export DATA_SUFFIX='_tmp'

echo "START: $(date)"
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export MODEL_DIR=/scratch/project_2002026/bert/cased_L-12_H-768_A-12
export DATA_DIR=/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/CORE-final
export OUTPUT_DIR=data
mkdir -p "$OUTPUT_DIR"
NBLOCKS=3
export DATA_SUFFIX="_tmp"
cp -n $DATA_DIR/test.tsv $OUTPUT_DIR/test$DATA_SUFFIX.tsv
cp -n $DATA_DIR/dev.tsv $OUTPUT_DIR/dev$DATA_SUFFIX.tsv
cp -n $DATA_DIR/train.tsv $OUTPUT_DIR/train$DATA_SUFFIX.tsv
srun python preprocess_data.py -i $OUTPUT_DIR/train$DATA_SUFFIX.tsv -v $MODEL_DIR/vocab.txt -t eng --all_blocks True
NLABELS=56
TMP_FILE=_tmp_$NBLOCKS
rm labels.json
echo "END: $(date)"
