#!/bin/bash
#FLUX: --job-name=crunchy-salad-6129
#FLUX: --urgency=16

module load icc
${PROTEIN_PROJECT_DIR}/program.o --bondEn ${1} --iterations ${2} --split ${3} --blocks ${4} --length ${5} --runId ${SLURM_ARRAY_TASK_ID:-0} \
    --Xm ${6:-200} --Ym ${7:-500} --Zm ${8:-200} --dimensions ${9:-4} --writeId ${10:-1}
