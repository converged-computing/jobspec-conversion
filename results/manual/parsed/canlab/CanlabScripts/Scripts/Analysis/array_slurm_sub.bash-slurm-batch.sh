#!/bin/bash
#SBATCH --job-name=MPA1-l1m1
#SBATCH --mail-user=marta.ceko@gmail.com
#SBATCH --mail-type=ALL
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8000
#SBATCH --time=01:30:00
#SBATCH --qos=blanca-ics

module load matlab
matlab -nodisplay -nosplash -nodesktop -r "try, load ('DSGN_sub.mat','DSGN_sub'); canlab_glm_subject_levels(DSGN_sub{$SLURM_ARRAY_TASK_ID}); catch me, fprintf('%s / %s\n',me.identifier,me.message), exit, end, exit"
