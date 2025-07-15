#!/bin/bash
#FLUX: --job-name=SLU
#FLUX: --queue=2080ti
#FLUX: --priority=16

dataset=(atis snips)
ratio=(0.05 0.1 1.0)
model=(birnn birnn+crf focus)
cur_d=${dataset[SLURM_ARRAY_TASK_ID / 9]}
cur_r=${ratio[(SLURM_ARRAY_TASK_ID % 9) / 3]}
cur_m=${model[SLURM_ARRAY_TASK_ID % 3]}
source activate slu
./run/run_slu_bert.sh ${cur_d} ${cur_r} ${cur_m}
