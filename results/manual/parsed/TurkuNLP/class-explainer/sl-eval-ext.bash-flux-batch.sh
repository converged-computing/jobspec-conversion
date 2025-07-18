#!/bin/bash
#FLUX: --job-name=kw_selec
#FLUX: --queue=small
#FLUX: -t=11700
#FLUX: --urgency=16

mkdir -p logs
rm logs/current.err
rm logs/current.out
ln -s $SLURM_JOBID.err logs/current.err
ln -s $SLURM_JOBID.out logs/current.out
module purge
module load pytorch/1.8
source /scratch/project_2002026/amanda/venv/bin/activate
echo "Data prefix: $5"
echo "Evaluation parameters: PredTh=$3, SelFreq=$1, WordsPerDoc=$2, FreqPrefTh=$4"
srun python run_evaluation.py \
  --data explanations/th$3/$5 \
  --prediction_th $3 \
  --selection_freq $1 \
  --words_per_doc $2 \
  --frequent_predictions_th $4 \
  --save_n 1000 \
  --min_word_freq 5 \
  --save_file eval_output/svm_keywords_ \
  --filter selectf \
  --keyword_data eval_output/svm_keywords_ \
  --document_data explanations/$5 \
  --plot_file eval_output/plot_
seff $SLURM_JOBID
