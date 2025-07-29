#!/bin/bash
#SBATCH --job-name=ADAM_EXPERIMENT
#SBATCH --output=data/slurm_logs/%x-%j.out
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=8G
#SBATCH --qos=ephemeral
#SBATCH --exclude=saga01,saga02,saga03,saga04,saga05,saga06,saga07,saga08,saga10,saga11,saga12,saga13,saga14,saga15,saga16,saga17,saga18,saga19,saga20,saga21,saga22,saga23,saga24,saga25,saga26,gaia01,gaia02

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
