#!/bin/bash
#FLUX: --job-name=bumfuzzled-bits-3760
#FLUX: -t=1500
#FLUX: --urgency=16

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
