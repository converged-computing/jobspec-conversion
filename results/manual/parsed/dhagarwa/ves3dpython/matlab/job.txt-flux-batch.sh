#!/bin/bash
#FLUX: --job-name=adorable-noodle-4546
#FLUX: --priority=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < gputest.m
