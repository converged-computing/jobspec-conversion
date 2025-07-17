#!/bin/bash
#FLUX: --job-name=H1_S2
#FLUX: --queue=small
#FLUX: -t=600
#FLUX: --urgency=16

iStage=2
cd "STAGE_$iStage/scripts/"
folder=`pwd`
module load tryton/matlab/2021a
matlab -nodisplay -nodesktop -logfile $folder/../../STAGE_${iStage}.log <  $folder/RUN.m 
