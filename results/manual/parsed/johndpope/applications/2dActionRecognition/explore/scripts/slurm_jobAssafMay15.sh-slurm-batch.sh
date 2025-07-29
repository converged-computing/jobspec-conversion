#!/bin/bash
#FLUX: --job-name=serialJob
#FLUX: --queue=super
#FLUX: -t=10800
#FLUX: --urgency=16

module add matlab/2017a                                  # load software package
matlab -nodisplay -nodesktop -nosplash -r "run('/home2/s170480/matlab/applications/2dActionRecognition/explore/scripts/script_CellMD_OMETIFF_Gen2n3May15_arj.m'), exit"
