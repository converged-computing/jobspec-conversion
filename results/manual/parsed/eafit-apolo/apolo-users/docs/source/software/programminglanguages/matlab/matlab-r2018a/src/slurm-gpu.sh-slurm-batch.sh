#!/bin/bash
#FLUX: --job-name=test_matlab
#FLUX: --queue=accel
#FLUX: -t=1200
#FLUX: --urgency=16

module load matlab/r2018a
matlab -nosplash -nodesktop < gpu_script.m
