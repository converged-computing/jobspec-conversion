#!/bin/bash
#FLUX: --job-name=buttery-lizard-4514
#FLUX: -t=21600
#FLUX: --urgency=16

export MATLABPATH='$'/MouseMotionMapper/'

export MATLABPATH=$'/MouseMotionMapper/'
cd $MATLABPATH
listOfFiles=""
SAVEPATH=/MouseMotionMapper/trainings/
rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
module load matlab/R2013a
matlab -nosplash -nodesktop -nodisplay -singleCompThread -r "addpath(genpath('$MATLABPATH')); runSubsamples('$fileName',20,.25,20,'$SAVEPATH'); exit;"
