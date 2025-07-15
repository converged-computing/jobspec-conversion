#!/bin/bash
#FLUX: --job-name=profile
#FLUX: -N=64
#FLUX: --queue=large
#FLUX: -t=300
#FLUX: --priority=16

task="rs"
pp="lci"
max_level="6"
mode=${1:-"stat"}
srun --mpi=pmix bash -x ${ROOT_PATH}/profile_wrapper.sh $task $pp $max_level $mode
