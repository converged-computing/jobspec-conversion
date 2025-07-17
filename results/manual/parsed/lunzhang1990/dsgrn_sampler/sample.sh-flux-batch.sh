#!/bin/bash
#FLUX: --job-name=fat-gato-3422
#FLUX: --queue=main
#FLUX: -t=280800
#FLUX: --urgency=16

cd $PWD
module load python/3.5.2   intel/17.0.4
srun python3 sampleRun.py 64 1 
