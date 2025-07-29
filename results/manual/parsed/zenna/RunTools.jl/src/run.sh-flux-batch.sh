#!/bin/bash
#FLUX --job-name=crusty-mango-8076
#FLUX -t=43200
#FLUX --urgency=16

source activate tf
julia "$@"
