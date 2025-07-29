#!/bin/bash
#SBATCH --job-name={{{jobname}}}
#SBATCH --output={{{project_dir}}}/{{{tmp_dir}}}/slurm_%a.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --chdir={{{project_dir}}}
#SBATCH --array=0-{{{max_node}}}

export SINGULARITYENV_SLURM_ARRAY_TASK_ID='${SLURM_ARRAY_TASK_ID}'

{{#flags}}
{{/flags}}
{{#options}}
{{/options}}
module load simg_R/{{{r_version}}}
export SINGULARITYENV_SLURM_ARRAY_TASK_ID=${SLURM_ARRAY_TASK_ID}
Rscript {{{tmp_dir}}}/slurm_run.R
