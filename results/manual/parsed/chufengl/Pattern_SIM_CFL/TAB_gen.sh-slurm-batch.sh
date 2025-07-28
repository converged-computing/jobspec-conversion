#!/bin/bash
#FLUX: --job-name=sim_TAB_gen_ni
#FLUX: --queue=serial
#FLUX: -t=87120
#FLUX: --urgency=16

module load matlab/2016a
matlab -nodesktop  -r "addpath('/home/chufengl/test_folder/MOF_pat_sim','-end'); TAB_gen_ni;exit"
