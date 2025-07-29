#!/bin/bash
#FLUX --job-name=fugly-egg-2894
#FLUX -c=32
#FLUX --queue=production
#FLUX -t=356400
#FLUX --urgency=16

echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
./condor_submit.sh
