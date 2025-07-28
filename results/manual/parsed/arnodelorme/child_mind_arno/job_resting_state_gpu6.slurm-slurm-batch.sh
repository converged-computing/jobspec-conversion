#!/bin/bash
#FLUX: --job-name=ChildMindDL
#FLUX: --queue=gpu-shared
#FLUX: -t=172800
#FLUX: --urgency=16

source ~/.bashrc
cd /projects/ps-nemar/child_mind_2020
module load matlab
matlab -nodisplay -nosplash -nodesktop < /projects/ps-nemar/child_mind_2020/restingstate_dl_comet6.m
