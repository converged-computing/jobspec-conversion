#!/bin/bash
#FLUX: --job-name=StdModel_target_noCross
#FLUX: -c=20
#FLUX: -t=172800
#FLUX: --urgency=16

module load matlab/2021a
matlab <<EOF
s0_add_paths
doCross=false;
target='target';
start_idx=1;
% if choose_model = 'all', the total number of array jobs is 48 - if only one model is selected 12 array jobs
choose_model='all'; 
s2_fit_all_cluster
EOF
