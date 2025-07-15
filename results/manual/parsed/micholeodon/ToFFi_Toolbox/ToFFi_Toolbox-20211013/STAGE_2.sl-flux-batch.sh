#!/bin/bash
#FLUX: --job-name=crunchy-truffle-2793
#FLUX: -t=600
#FLUX: --priority=16

iStage=2
cd "STAGE_$iStage/scripts/"
folder=`pwd`
module load tryton/matlab/2021a
matlab -nodisplay -nodesktop -logfile $folder/../../STAGE_${iStage}.log <  $folder/RUN.m 
