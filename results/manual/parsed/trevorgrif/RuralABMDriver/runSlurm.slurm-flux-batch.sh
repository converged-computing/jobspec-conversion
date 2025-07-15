#!/bin/bash
#FLUX: --job-name=chunky-general-6008
#FLUX: -c=32
#FLUX: --priority=16

. /usr/modules/init/bash
module load julia
cd $SLURM_SUBMIT_DIR
julia -t 32 -p 32 -L distributed_startup.jl $FILE
