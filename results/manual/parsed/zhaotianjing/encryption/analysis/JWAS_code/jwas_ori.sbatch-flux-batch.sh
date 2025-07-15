#!/bin/bash
#FLUX: --job-name=accuracy
#FLUX: -c=2
#FLUX: --queue=bmh
#FLUX: -t=1134000
#FLUX: --priority=16

module load julia
srun julia /group/qtlchenggrp/tianjing/encryption/jwas_ori.jl $1 $2 $3
