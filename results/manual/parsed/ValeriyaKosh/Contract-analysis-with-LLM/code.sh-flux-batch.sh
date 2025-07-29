#!/bin/bash
#FLUX --job-name=fat-frito-0674
#FLUX -t=1500
#FLUX --urgency=16

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
