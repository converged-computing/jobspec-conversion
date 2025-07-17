#!/bin/bash
#FLUX: --job-name=confused-carrot-9763
#FLUX: -c=8
#FLUX: --queue=red,brown
#FLUX: -t=43200
#FLUX: --urgency=16

export PYTHONPATH='/home/jocl/explainabloomity/lm-evaluation-harness':$PYTHONPATH'
export PATH='/home/jocl/.conda/envs/lmeval/bin':$PATH'

nvidia-smi
module load Anaconda3/2021.05
source activate lmeval
conda env list
export PYTHONPATH='/home/jocl/explainabloomity/lm-evaluation-harness':$PYTHONPATH
export PATH='/home/jocl/.conda/envs/lmeval/bin':$PATH
python eval_mask.py
