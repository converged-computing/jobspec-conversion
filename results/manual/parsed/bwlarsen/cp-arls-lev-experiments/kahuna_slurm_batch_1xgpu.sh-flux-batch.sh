#!/bin/bash
#FLUX: --job-name=misunderstood-toaster-1627
#FLUX: -c=4
#FLUX: --exclusive
#FLUX: --queue=1xgpu
#FLUX: -t=561600
#FLUX: --urgency=16

module load matlab
echo Hostname:
hostname
echo MATLAB Command: $1
matlab -nosplash -nodesktop -nodisplay -r "addpath('/home/bwlarse/tensor_toolbox_sparse'); addpath('/home/bwlarse/matlab-tools'); $1; quit"
