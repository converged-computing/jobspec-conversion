#!/bin/bash
#FLUX: --job-name=PSPFullYear
#FLUX: -c=24
#FLUX: -t=43200
#FLUX: --priority=16

julia --depwarn=no PSPMIP.jl
