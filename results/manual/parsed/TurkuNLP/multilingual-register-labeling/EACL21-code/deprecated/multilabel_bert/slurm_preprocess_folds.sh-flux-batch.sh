#!/bin/bash
#FLUX: --job-name=tart-gato-9574
#FLUX: --urgency=16

export OMP_NUM_THREADS='$SLURM_CPUS_PER_TASK'
export MODEL_DIR='/scratch/project_2002026/bert/cased_L-12_H-768_A-12'
export DATA_DIR='/scratch/project_2002026/multilabel_bert/neuro_classifier/multilabel/CORE-final'
export OUTPUT_DIR='data/train-10-fold-prep'
export DATA_SUFFIX=''

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
export OUTPUT_DIR=data/train-10-fold-prep
mkdir -p "$OUTPUT_DIR"
POS="0"
export DATA_SUFFIX=""
for f in {9,10}; do
  ## Prepare data for BERT fine-tuning
  export DATA_PREFIX="fold-$f"
  #srun python preprocess_data.py -i $OUTPUT_DIR/$DATA_PREFIX-test.tsv -v $MODEL_DIR/vocab.txt -t eng -l $OUTPUT_DIR/labels.json -L data/labels.json -w $POS
  #srun python preprocess_data.py -i $OUTPUT_DIR/$DATA_PREFIX-train.tsv -v $MODEL_DIR/vocab.txt -t eng -L data/labels.json -w $POS
  ## Prepare data for BERT prediction over full documents
  export DATA_PREFIX="fulldoc-fold-$f"
  #srun python preprocess_data.py -i $OUTPUT_DIR/$DATA_PREFIX-test.tsv -v $MODEL_DIR/vocab.txt -t eng -l $OUTPUT_DIR/labels.json -L data/labels.json --all_blocks True
  srun python preprocess_data.py -i $OUTPUT_DIR/$DATA_PREFIX-train.tsv -v $MODEL_DIR/vocab.txt -t eng -l $OUTPUT_DIR/labels.json -L data/labels.json --all_blocks True
done
ln -s test.tsv data/fulldoc_test.tsv
ln -s dev.tsv data/fulldoc_dev.tsv
NLABELS=56
rm -f labels.json
echo "END: $(date)"
