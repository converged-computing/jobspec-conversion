#!/bin/bash
#FLUX: --job-name=MATLAB_ex
#FLUX: --queue=ssd
#FLUX: -t=300
#FLUX: --urgency=16

module load matlab
matlab -nodisplay < MATLAB_example.m
