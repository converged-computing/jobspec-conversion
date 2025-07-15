#!/bin/bash
#FLUX: --job-name=confused-rabbit-4186
#FLUX: --priority=16

cd $PWD
module load python/3.5.2   intel/17.0.4
srun python3 sampleRun.py 64 1 
