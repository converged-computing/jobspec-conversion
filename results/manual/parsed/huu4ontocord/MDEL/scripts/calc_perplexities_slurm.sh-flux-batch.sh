#!/bin/bash
#FLUX: --job-name=doopy-poo-5073
#FLUX: -c=4
#FLUX: --queue=small-g
#FLUX: -t=3600
#FLUX: --urgency=16

export WANDB_MODE='offline'
export HF_HOME='/scratch/project_462000259/jstillerman/hf_cache'

if command -v python3 &>/dev/null; then
  PYTHON_CMD=python3
else
  PYTHON_CMD=python
fi
for MODEL in "Multi-Domain-Expert-Layers/expert-arxiv" "Multi-Domain-Expert-Layers/expert-freelaw" "Multi-Domain-Expert-Layers/expert-github" "EleutherAI/pythia-1b-deduped"
do
  for DATASET in "Multi-Domain-Expert-Layers/arxiv" "Multi-Domain-Expert-Layers/freelaw" "Multi-Domain-Expert-Layers/github"
  do
    for SPLIT in "validation_domain" "train" "validation_pile"
    do
      JOB_NAME="${MODEL}-${DATASET}-${SPLIT}"
      sbatch --job-name="$JOB_NAME" <<EOT
echo RUNNING $MODEL on $DATASET with $SPLIT
rocm-smi
export WANDB_MODE=offline
export HF_HOME="/scratch/project_462000259/jstillerman/hf_cache"
$PYTHON_CMD ../../src/mdel/calculate_perplexity.py --model $MODEL --dataset $DATASET --split $SPLIT
EOT
    done
  done
done
