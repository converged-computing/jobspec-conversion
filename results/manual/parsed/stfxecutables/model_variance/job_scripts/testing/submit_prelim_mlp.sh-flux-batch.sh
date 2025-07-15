#!/bin/bash
#FLUX: --job-name=mlp_hps
#FLUX: -c=6
#FLUX: -t=28800
#FLUX: --priority=16

module load nixpkgs/16.09 intel/2018.3 fsl/6.0.1
SCRATCH="$(readlink -f "$SCRATCH")"
PROJECT="$SCRATCH/model_variance"
RUN_SCRIPT="$PROJECT/run_hperturbs.sh"
PY_SCRIPTS="$PROJECT/scripts"
PY_SCRIPT="$(readlink -f "$PY_SCRIPTS/script.py")"
bash "$RUN_SCRIPT"
