#!/bin/bash
#FLUX: --job-name=purple-muffin-6557
#FLUX: --urgency=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py black $RATIO ${SLURM_ARRAY_TASK_ID}
