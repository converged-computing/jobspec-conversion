#!/bin/bash
#FLUX: --job-name=ornery-cinnamonbun-2513
#FLUX: --urgency=16

spack unload -a
spack load /lklqe3u
spack load /saj4vss
spack load py-pandas
python3 main.py nofair ${SLURM_ARRAY_TASK_ID}
