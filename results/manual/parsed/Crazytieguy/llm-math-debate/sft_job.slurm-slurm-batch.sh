#!/bin/bash
#FLUX: --job-name=llm_math_debate_sft
#FLUX: -c=4
#FLUX: -t=21600
#FLUX: --urgency=16

singularity exec --nv --overlay $SCRATCH/llm-math-debate.ext3:ro /scratch/work/public/singularity/cuda11.8.86-cudnn8.7-devel-ubuntu22.04.2.sif /bin/bash -c "
source /ext3/env.sh
python -m llm_math_debate.training.sft
python -m llm_math_debate.training.sft_test
"
