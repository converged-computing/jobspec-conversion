#!/bin/bash
#FLUX: --job-name=model_C1
#FLUX: -c=28
#FLUX: -t=362340
#FLUX: --priority=16

module load MATLAB/R2016a
matlab -nodisplay < systematic_connectivity.m
