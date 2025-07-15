#!/bin/bash
#FLUX: --job-name=eccentric-bike-9481
#FLUX: -n=48
#FLUX: --queue=skl_fua_dbg
#FLUX: -t=3600
#FLUX: --priority=16

set -e
cd $SLURM_SUBMIT_DIR
source julia.env
echo "precompiling $(date)"
bin/julia --project -O3 --check-bounds=no precompile.jl
echo "finished! $(date)"
