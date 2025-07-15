#!/bin/bash
#FLUX: --job-name=psycho-chip-8266
#FLUX: -t=21600
#FLUX: --priority=16

export MATLABPATH='$'/MouseMotionMapper/'

export MATLABPATH=$'/MouseMotionMapper/'
cd $MATLABPATH
listOfFiles=""
SAVEPATH=/MouseMotionMapper/trainings/
rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
module load matlab/R2013a
matlab -nosplash -nodesktop -nodisplay -singleCompThread -r "addpath(genpath('$MATLABPATH')); runSubsamples('$fileName',20,.25,20,'$SAVEPATH'); exit;"
