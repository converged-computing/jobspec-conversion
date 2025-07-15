#!/bin/bash
#FLUX: --job-name=moolicious-chair-1707
#FLUX: --exclusive
#FLUX: --priority=16

module load matlab
echo Hostname:
hostname
echo MATLAB Command: $1
matlab -nosplash -nodesktop -nodisplay -r "addpath('/home/bwlarse/tensor_toolbox_sparse'); addpath('/home/bwlarse/matlab-tools'); $1; quit"
