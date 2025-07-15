#!/bin/bash
#FLUX: --job-name=tart-nalgas-3488
#FLUX: -t=194400
#FLUX: --urgency=16

export MATLABPATH='$'/MouseMotionMapper/'

export MATLABPATH=$'/MouseMotionMapper/'
cd $MATLABPATH
TRAINDATA=/MouseMotionMapper/demo/trainingSet_new10.mat
SAVEPATH=/MouseMotionMapper/Kmeans/
module load matlab/R2013a
matlab -nosplash -nodesktop -nodisplay -singleCompThread -r "addpath(genpath('$MATLABPATH')); runCluster('101','$SAVEPATH','$TRAINDATA'); exit;"
