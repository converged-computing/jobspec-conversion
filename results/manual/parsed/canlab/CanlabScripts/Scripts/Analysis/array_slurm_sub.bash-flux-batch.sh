#!/bin/bash
#FLUX: --job-name=MPA1-l1m1
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nosplash -nodesktop -r "try, load ('DSGN_sub.mat','DSGN_sub'); canlab_glm_subject_levels(DSGN_sub{$SLURM_ARRAY_TASK_ID}); catch me, fprintf('%s / %s\n',me.identifier,me.message), exit, end, exit"
