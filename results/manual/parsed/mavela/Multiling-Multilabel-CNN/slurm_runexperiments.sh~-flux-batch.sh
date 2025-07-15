#!/bin/bash
#FLUX: --job-name=purple-lizard-4584
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export OUTPUT_DIR='/scratch/project_2002026/cnn/multiling-cnn/pretty/output'
export EVALSET='dev    # set to "test" for final experiments, otherwise dev'
export SCRIPT='$(basename "$0")'
export SCRIPTDIR='/scratch/project_2002026/cnn/multiling-cnn/pretty'
export WVDIR='$SCRIPTDIR/../wordvecs'
export DATADIR='/scratch/project_2002026/cnn/multiling-cnn/fasttext/2level'
export MODELDIR='$SCRIPTDIR/models'
export RESULTDIR='$SCRIPTDIR/results'
export WORD_VECS='en:$WVDIR/wiki.multi.en.vec'

echo "START: $(date)"
module purge
module load tensorflow
source /scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/VENV3/bin/activate
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export OUTPUT_DIR=/scratch/project_2002026/cnn/multiling-cnn/pretty/output
mkdir -p "$OUTPUT_DIR"
export EVALSET=dev    # set to "test" for final experiments, otherwise dev
set -euo pipefail
export SCRIPT="$(basename "$0")"
export SCRIPTDIR=/scratch/project_2002026/cnn/multiling-cnn/pretty
export WVDIR="$SCRIPTDIR/../wordvecs"
export DATADIR=/scratch/project_2002026/cnn/multiling-cnn/fasttext/2level
export MODELDIR="$SCRIPTDIR/models"
export RESULTDIR="$SCRIPTDIR/results"
EPOCHS=15
MAX_WORDS=100000
export WORD_VECS="en:$WVDIR/wiki.multi.en.vec"
mkdir -p "$MODELDIR"
mkdir -p "$RESULTDIR"
for l in {0.0001,0.001,0.003}; #,0.005,0.006}; 
do
for t in {0.4,0.5,0.6} #,0.4,0.5,0.6}
do python3 "$SCRIPTDIR/trainml_multilabel_cnn.py" \
    --epochs "$EPOCHS" \
    --limit "$MAX_WORDS" \
    --learning_rate $l \
    --word-vectors "$WORD_VECS" \
    --input "en:$DATADIR/train.tsv" \
    --output "$MODELDIR/en.model" \
    --validation "en:$DATADIR/dev.tsv" \
    --predictions "$DATADIR/predictions.txt" \
    --threshold $t \
    --kernel-size 2
done
done
 #   | tee -a "$RESULTDIR/en-fi.txt"
