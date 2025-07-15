#!/bin/bash
#FLUX: --job-name=fat-fork-0915
#FLUX: --urgency=16

source activate tf
julia "$@"
