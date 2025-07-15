#!/bin/bash
#FLUX: --job-name=infocap_m
#FLUX: -c=2
#FLUX: --priority=16

ml MATLAB
matlab -nojvm -nodisplay<<-EOF
for cond=1:2
infocapacity_hopf_errorhete(${SLURM_ARRAY_TASK_ID},cond);
end
EOF
