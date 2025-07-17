#!/bin/bash
#FLUX: --job-name=milky-parsnip-4767
#FLUX: -t=43200
#FLUX: --urgency=16

source activate tf
julia "$@"
