#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=64000
#SBATCH --time=2-06:00:00
#SBATCH --array=1

export MATLABPATH='$'/MouseMotionMapper/'

export MATLABPATH=$'/MouseMotionMapper/'
cd $MATLABPATH
TRAINDATA=/MouseMotionMapper/demo/trainingSet_new10.mat
SAVEPATH=/MouseMotionMapper/Kmeans/
module load matlab/R2013a
matlab -nosplash -nodesktop -nodisplay -singleCompThread -r "addpath(genpath('$MATLABPATH')); runCluster('101','$SAVEPATH','$TRAINDATA'); exit;"
