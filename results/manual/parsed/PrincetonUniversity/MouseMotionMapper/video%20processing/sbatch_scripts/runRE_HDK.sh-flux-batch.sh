#!/bin/bash
#FLUX: --job-name=bricky-arm-0674
#FLUX: -t=21600
#FLUX: --urgency=16

export MATLABPATH='$'/MouseMotionMapper/'

export MATLABPATH=$'/MouseMotionMapper/'
cd $MATLABPATH
listOfFiles=""
Kmeans=''
TrainingSet='/MouseMotionMapper/demo/trainingSet_new10.mat'
SavePath='MouseMotionMapper/Reembedding/'
EndName='_p10_HD_101.mat'
NumPCA=10
rowNumber=$SLURM_ARRAY_TASK_ID
fileName=$(sed "${rowNumber}q;d" $listOfFiles)
echo $listOfFiles
echo $rowNumber
echo $fileName
module load matlab/R2013a
matlab -nosplash -nodesktop -nodisplay -singleCompThread -r "addpath(genpath('$MATLABPATH'));\
	makeHDK_proj('$fileName',$Kmeans,$TrainingSet,$SavePath,$EndName,$NumPCA); exit;"
