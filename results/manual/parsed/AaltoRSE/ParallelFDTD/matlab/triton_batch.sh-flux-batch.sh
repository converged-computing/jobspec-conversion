#!/bin/bash
#FLUX: --job-name=ornery-cat-7645
#FLUX: -t=600
#FLUX: --priority=16

module load matlab/r2019b
srun matlab -nojvm -nosplash -batch "testBench()"
