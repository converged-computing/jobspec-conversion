#!/bin/bash
#FLUX: --job-name=placid-peanut-butter-4073
#FLUX: -t=43200
#FLUX: --urgency=16

source activate tf
julia "$@"
