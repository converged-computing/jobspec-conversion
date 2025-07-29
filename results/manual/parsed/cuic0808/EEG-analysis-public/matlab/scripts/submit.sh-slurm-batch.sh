#!/bin/bash
#FLUX: --job-name=wavelet
#FLUX: --queue=normal
#FLUX: -t=18000
#FLUX: --urgency=16

module purge all
module load matlab/r2020b
cd /home/yyr4332/project/matlab/
matlab -nosplash -nodesktop -singleCompThread -r yy_auto_process
