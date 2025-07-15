#!/bin/bash
#FLUX: --job-name=psycho-diablo-6894
#FLUX: --queue=neuro-hsc
#FLUX: --urgency=16

module load matlab/R2022a
cd /carc/scratch/projects/mckenzie2016183/code/matlab
matlab -singleCompThread -nodisplay  -nodesktop  -nojvm -r "sm_PredictTemple_getAllFeatures_CARC($SLURM_ARRAY_TASK_ID); exit;"
