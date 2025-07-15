#!/bin/bash
#FLUX: --job-name=doopy-onion-0655
#FLUX: --priority=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py female $RATIO ${SLURM_ARRAY_TASK_ID}
