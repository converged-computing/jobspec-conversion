#!/bin/bash
#FLUX: --job-name=tart-staircase-2481
#FLUX: -t=360000
#FLUX: --urgency=16

echo "Arguments passed to the script: $@"
source /proj/nobackup/hpc2n2023-124/llm_qlora/venv/bin/activate
srun $1
