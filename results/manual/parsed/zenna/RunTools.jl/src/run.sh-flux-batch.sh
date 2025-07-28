#!/bin/bash
#FLUX: --job-name=carnivorous-peanut-9842
#FLUX: -t=43200
#FLUX: --urgency=16

source activate tf
julia "$@"
