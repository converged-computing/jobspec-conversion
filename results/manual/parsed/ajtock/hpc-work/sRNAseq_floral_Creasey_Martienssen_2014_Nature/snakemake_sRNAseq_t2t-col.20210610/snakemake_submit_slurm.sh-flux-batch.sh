#!/bin/bash
#FLUX: --job-name=outstanding-knife-8158
#FLUX: -c=32
#FLUX: --urgency=16

echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
./condor_submit.sh
