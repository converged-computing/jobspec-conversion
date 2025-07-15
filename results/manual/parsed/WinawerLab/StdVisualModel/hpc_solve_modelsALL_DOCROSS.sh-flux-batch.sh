#!/bin/bash
#FLUX: --job-name=StdModel_all_Cross
#FLUX: -c=48
#FLUX: -t=532800
#FLUX: --priority=16

module load matlab/2021a
matlab <<EOF
s0_add_paths
doCross=true;
target='all';
start_idx=1;
% if choose_model = 'all', the total number of array jobs is 48 - if only one model is selected 12 array jobs
choose_model='all';
s2_fit_all_cluster
EOF
