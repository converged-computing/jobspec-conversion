#!/bin/bash
#FLUX: --job-name=misunderstood-malarkey-0232
#FLUX: -n=4
#FLUX: --queue=stats.p
#FLUX: -t=259200
#FLUX: --urgency=16

cd /home/abakis/git/covid_SEIHR_county
if [ $SLURM_ARRAY_TASK_ID == 1 ]; then
sbatch --depend=afterany:$SLURM_ARRAY_JOB_ID slurm_submissions/3_gen_pp_gq.sh
fi
julia +1.8 --project --threads 4 scripts/fit_model.jl $SLURM_ARRAY_TASK_ID
