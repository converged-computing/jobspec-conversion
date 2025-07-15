#!/bin/bash
#FLUX: --job-name=bloated-hope-5138
#FLUX: --urgency=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < testRun.m
