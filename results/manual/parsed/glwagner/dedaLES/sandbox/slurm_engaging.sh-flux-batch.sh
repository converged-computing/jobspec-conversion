#!/bin/bash
#FLUX: --job-name=outstanding-puppy-3251
#FLUX: -N=4
#FLUX: --queue=sched_mit_hill
#FLUX: -t=43200
#FLUX: --priority=16

mpiexec echo "test"
