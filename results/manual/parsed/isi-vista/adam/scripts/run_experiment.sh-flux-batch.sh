#!/bin/bash
#FLUX: --job-name=ADAM_EXPERIMENT
#FLUX: --queue=ephemeral
#FLUX: --priority=16

set -euo pipefail
echo "Current node: $(hostname)"
echo "Current working directory: $(pwd)"
echo "Starting run at: $(date)"
echo "Job ID: $SLURM_JOB_ID"
echo
if time PYTHONPATH=. python adam/experiment/log_experiment.py "$1"; then
    EXITCODE=0
else
    EXITCODE=$?
fi
echo
echo "Job finished with exit code $EXITCODE at: $(date)"
