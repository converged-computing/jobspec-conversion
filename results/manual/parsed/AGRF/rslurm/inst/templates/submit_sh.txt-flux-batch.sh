#!/bin/bash
#FLUX: --job-name={{{jobname}}}
#FLUX: --priority=16

export SINGULARITYENV_SLURM_ARRAY_TASK_ID='${SLURM_ARRAY_TASK_ID}'

{{#flags}}
{{/flags}}
{{#options}}
{{/options}}
module load simg_R/{{{r_version}}}
export SINGULARITYENV_SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID}
Rscript {{{tmp_dir}}}/slurm_run.R
