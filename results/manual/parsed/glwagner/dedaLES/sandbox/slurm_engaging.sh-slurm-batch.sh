#!/bin/bash
#FLUX: --job-name=dinosaur-leader-4925
#FLUX: -N=4
#FLUX: --queue=sched_mit_hill
#FLUX: -t=43200
#FLUX: --urgency=16

mpiexec echo "test"
