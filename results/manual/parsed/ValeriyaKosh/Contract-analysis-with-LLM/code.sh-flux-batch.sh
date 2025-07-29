#!/bin/bash
#FLUX --job-name=misunderstood-gato-6203
#FLUX -t=1500
#FLUX --urgency=16

module load model-huggingface/all
  # run python
srun python Contract-analysis-with-LLM/code.py
