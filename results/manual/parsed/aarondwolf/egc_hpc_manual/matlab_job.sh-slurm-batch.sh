#!/bin/bash
#FLUX: --job-name=matlab_job
#FLUX: --queue=day
#FLUX: -t=300
#FLUX: --urgency=16

cd /home/adw54/Documents/egc_hpc_manual
module load MATLAB/2019a-parallel
matlab -nodisplay < matlab/master.m
