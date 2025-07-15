#!/bin/bash
#FLUX: --job-name=stanky-soup-0185
#FLUX: -N=2
#FLUX: --queue=short
#FLUX: --urgency=16

ulimit -l unlimited
julia test_slurm_manager.jl
