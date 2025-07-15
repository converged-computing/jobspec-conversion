#!/bin/bash
#FLUX: --job-name=dirty-ricecake-8167
#FLUX: --priority=16

module load matlab/r2018a
matlab -nosplash -nodesktop < gpu_script.m
