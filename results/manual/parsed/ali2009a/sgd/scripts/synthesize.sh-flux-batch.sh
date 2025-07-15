#!/bin/bash
#FLUX: --job-name=synthesize
#FLUX: -c=2
#FLUX: -t=86400
#FLUX: --priority=16

module load matlab/2018a
project_root="/home/aliarab/src/sgd/scripts"
cd $project_root
matlab -nodesktop -r synthesize_wrapper
