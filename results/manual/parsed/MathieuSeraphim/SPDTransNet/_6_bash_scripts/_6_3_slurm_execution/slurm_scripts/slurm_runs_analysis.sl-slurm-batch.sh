#!/bin/bash
#FLUX: --job-name=runs_analysis
#FLUX: -c=8
#FLUX: -t=72000
#FLUX: --urgency=16

module purge
module load cpuarch/amd
module load pytorch-gpu/py3/1.11.0
PATH=$PATH:~/.local/bin
export PATH
set -x
srun python -u command_line_tester.py --run_analysis_config_name _SPD_from_EEG_base_runs_analysis_config.yaml
