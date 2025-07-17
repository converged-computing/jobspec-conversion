#!/bin/bash
#FLUX: --job-name=rainbow-snack-0770
#FLUX: -c=32
#FLUX: --queue=production
#FLUX: -t=356400
#FLUX: --urgency=16

echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
./condor_submit.sh
