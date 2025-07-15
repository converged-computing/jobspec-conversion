#!/bin/bash
#FLUX: --job-name="just_a_test"
#FLUX: -t=7200
#FLUX: --priority=16

module load matlab
matlab -nodisplay -nodesktop < my_matlab_program.m
