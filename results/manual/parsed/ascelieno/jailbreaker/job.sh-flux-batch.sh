#!/bin/bash
#FLUX: --job-name=moolicious-cherry-5051
#FLUX: --queue=amd_gpu
#FLUX: -t=360000
#FLUX: --urgency=16

echo "Arguments passed to the script: $@"
source /proj/nobackup/hpc2n2023-124/llm_qlora/venv/bin/activate
srun $1
