#!/bin/bash
#FLUX: --job-name=lovely-pot-8374
#FLUX: --priority=16

export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/opt/apps/cuda9_0/cudnn/7.0/lib64 '

module list
module load cuda/9.0
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/opt/apps/cuda9_0/cudnn/7.0/lib64 
cd $WORK/TestDeepFuzz #change this line  based on where you cloned the project
pwd
date
python clgen.py  --config /work/05359/sohil777/maverick2/TestDeepFuzz/clgen/tests/data/tiny/config.pbtxt         # Do not use ibrun or any other MPI launcher
scp -r /tmp/experiments $WORK # THIS IS IMPORTANT DO NOT REMOVE 
