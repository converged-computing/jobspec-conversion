#!/bin/bash
#FLUX: --job-name=outstanding-parrot-7736
#FLUX: -t=600
#FLUX: --urgency=16

module load matlab/r2019b
srun matlab -nojvm -nosplash -batch "testBench()"
