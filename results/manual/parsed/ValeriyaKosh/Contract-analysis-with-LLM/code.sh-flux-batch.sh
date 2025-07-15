#!/bin/bash
#FLUX: --job-name=confused-hope-7278
#FLUX: -t=1500
#FLUX: --urgency=16

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
