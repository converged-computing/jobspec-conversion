#!/bin/bash
#FLUX: --job-name=expressive-leg-5118
#FLUX: -c=8
#FLUX: -t=170
#FLUX: --urgency=16

module load matlab
cd /home/shaws5/projects/def-beckers/shaws5/Research_code/EEGnet/Sharcnet/sub_files
matlab -nodesktop -nosplash -nodisplay -r "run('process_RunningNFB_loopIDX_117to117.m'); exit"
