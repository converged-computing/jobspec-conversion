#!/bin/bash
#FLUX: --job-name=myjob
#FLUX: -c=20
#FLUX: --queue=medium
#FLUX: --urgency=16

pwd; hostname;
echo "Starting at wall clock time:"
date
echo "Running CMT on $SLURM_CPUS_ON_NODE CPU cores"
module load gcc-9.2.0
module load ngsolve/serial
module load intel
python3 $HOME/local/fiberamp/cmt/usage_examples/lase_thulium.py
echo "Ending at wall clock time:"
date
