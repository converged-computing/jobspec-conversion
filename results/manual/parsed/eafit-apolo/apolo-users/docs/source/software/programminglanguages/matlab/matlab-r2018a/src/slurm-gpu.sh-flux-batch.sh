#!/bin/bash
#FLUX: --job-name=swampy-mango-9060
#FLUX: --urgency=16

module load matlab/r2018a
matlab -nosplash -nodesktop < gpu_script.m
