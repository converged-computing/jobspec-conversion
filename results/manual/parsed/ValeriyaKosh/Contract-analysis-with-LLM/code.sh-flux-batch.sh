#!/bin/bash
#FLUX: --job-name=lovable-arm-0449
#FLUX: -t=1500
#FLUX: --priority=16

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
