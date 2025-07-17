#!/bin/bash
#FLUX: --job-name=lovable-blackbean-7734
#FLUX: --queue=serial
#FLUX: -t=87120
#FLUX: --urgency=16

module load matlab/2015a
matlab -nodesktop  -r "mat2h5('/home/chufengl/test_folder/MOF_pat_sim/MOF_batch13','MOF_2C_Zn_edge',1,40)"
