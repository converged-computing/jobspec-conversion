#!/bin/bash
#FLUX --job-name=arid-sundae-2323
#FLUX -t=43200
#FLUX --urgency=16

source activate tf
julia "$@"
