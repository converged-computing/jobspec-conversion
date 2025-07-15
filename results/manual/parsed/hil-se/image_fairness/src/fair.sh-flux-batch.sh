#!/bin/bash
#FLUX: --job-name=hello-arm-1707
#FLUX: --urgency=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py fair ${SLURM_ARRAY_TASK_ID}
