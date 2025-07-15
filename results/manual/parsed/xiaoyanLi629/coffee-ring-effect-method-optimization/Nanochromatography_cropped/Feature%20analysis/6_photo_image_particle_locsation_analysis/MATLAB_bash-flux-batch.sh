#!/bin/bash
#FLUX: --job-name=test
#FLUX: -t=108000
#FLUX: --priority=16

MATLAB/2021a Pixel_js_analysis.m
scontrol show job $SLURM_JOB_ID           ### write job information to output file
js -j $SLURM_JOB_ID 
