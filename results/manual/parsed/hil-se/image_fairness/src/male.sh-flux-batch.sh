#!/bin/bash
#FLUX: --job-name=fugly-noodle-6266
#FLUX: --priority=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py male $RATIO ${SLURM_ARRAY_TASK_ID}
