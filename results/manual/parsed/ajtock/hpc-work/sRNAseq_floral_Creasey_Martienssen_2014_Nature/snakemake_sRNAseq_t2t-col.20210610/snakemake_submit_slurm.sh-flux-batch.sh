#!/bin/bash
#FLUX: --job-name=buttery-plant-6952
#FLUX: -c=32
#FLUX: --priority=16

echo "Number of CPUs used: $SLURM_CPUS_PER_TASK"
echo "This job is running on:"
hostname
./condor_submit.sh
