#!/bin/bash
#FLUX: --job-name=prepInputs
#FLUX: -c=40
#FLUX: -t=86400
#FLUX: --priority=16

module load matlab/2021a
matlab <<EOF
s0_add_paths
s1_prepare_inputs(1)
s1_prepare_inputs(2)
s1_prepare_inputs(3)
s1_prepare_inputs(4)
EOF
