#!/bin/bash
#FLUX: --job-name=just_a_test
#FLUX: --queue=short
#FLUX: -t=7200
#FLUX: --urgency=16

module load matlab
matlab -nodisplay -nodesktop < my_matlab_program.m
