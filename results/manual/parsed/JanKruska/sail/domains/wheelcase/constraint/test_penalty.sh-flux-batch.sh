#!/bin/bash
#FLUX: --job-name=fugly-pancake-8921
#FLUX: --exclusive
#FLUX: --queue=hpc
#FLUX: -t=7200
#FLUX: --urgency=16

export MALLOC_ARENA_MAX='4'

export MALLOC_ARENA_MAX=4
module load java/default
module load cuda/default
module load matlab/R2019b
matlab -batch "test_penalty"
