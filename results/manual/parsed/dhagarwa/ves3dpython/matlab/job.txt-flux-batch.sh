#!/bin/bash
#FLUX: --job-name=fuzzy-bike-5435
#FLUX: --urgency=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < gputest.m
