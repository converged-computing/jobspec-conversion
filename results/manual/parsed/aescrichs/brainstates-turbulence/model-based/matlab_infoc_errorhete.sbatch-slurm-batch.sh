#!/bin/bash
#SBATCH --job-name=infocap_m
#SBATCH --output=jobid-%A_%a.out
#SBATCH --error=jobid-%A_%a.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=2
#SBATCH --mem=2G
#SBATCH --array=1-100

ml MATLAB
matlab -nojvm -nodisplay<<-EOF
for cond=1:2
infocapacity_hopf_errorhete(${SLURM_ARRAY_TASK_ID},cond);
end
EOF
