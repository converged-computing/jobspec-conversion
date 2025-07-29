#!/bin/bash
#FLUX --job-name=hairy-rabbit-4367
#FLUX --queue=gpu
#FLUX -t=600
#FLUX --urgency=16

module load matlab/r2019b
srun matlab -nojvm -nosplash -batch "testBench()"
