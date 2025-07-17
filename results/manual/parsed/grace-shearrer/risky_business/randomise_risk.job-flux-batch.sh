#!/bin/bash
#FLUX: --job-name=phat-pot-0977
#FLUX: -t=86400
#FLUX: --urgency=16

/projects/niblab/modules/software/fsl/5.0.10/bin/randomise -i /projects/niblab/data/eric_data/W1/milkshake/level3_grace_edit/cope${SLURM_ARRAY_TASK_ID}_risk_race.gfeat/cope1.feat/filtered_func_data.nii.gz -o /projects/niblab/data/eric_data/W1/milkshake/level3_grace_edit/double_check/cope${SLURM_ARRAY_TASK_ID}_riskrace_randomized -d /projects/niblab/data/eric_data/W1/milkshake/level3_grace_edit/cope${SLURM_ARRAY_TASK_ID}_risk_race.gfeat/design.mat -t /projects/niblab/data/eric_data/W1/milkshake/level3_grace_edit/cope${SLURM_ARRAY_TASK_ID}_risk_race.gfeat/design.con -n 5000 -T -m /projects/niblab/data/eric_data/W1/milkshake/level3_grace_edit/cope${SLURM_ARRAY_TASK_ID}_risk_race.gfeat/mask.nii.gz
