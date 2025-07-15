#!/bin/bash
#FLUX: --job-name=buttery-cupcake-1379
#FLUX: --priority=16

module load matlab
matlab -nodesktop -nodisplay -nosplash < testRun.m
